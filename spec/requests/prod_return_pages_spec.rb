require 'spec_helper'


describe "ProdReturnPages" do
	subject { page }

	let!(:user) { FactoryGirl.create(:user) }
	before do
		sign_in user
	end

=begin
	describe "adding new prod_return" do
		before do
			visit new_prod_return_path
		end
		it { should have_content("Dodaj nowy ticket zwrotu") }
		describe "submiting form with incorrect " do
			describe "auction_name" do
				before do
					fill_in "prod_return_auction_name", with:""
					fill_in "prod_return_client_name", with:"Michal"
					expect { click_button "Gotowe" }.to change(ProdReturn, :count).by(0)
				end
				it { should have_content("Blad") }
			end
			describe "client_name" do
				before do
					fill_in "prod_return_auction_name", with:"Krzeslo"
					fill_in "prod_return_client_name", with:""
					expect { click_button "Gotowe" }.to change(ProdReturn, :count).by(0)
				end
				it { should have_content("Blad") }
			end
			describe "auction_date-year" do
				before do
					fill_in "prod_return_auction_name", with:"Krzeslo"
					fill_in "prod_return_client_name", with:"Michal"
					select "2016", from:"auction_date_year"
					expect { click_button "Gotowe" }.to change(ProdReturn, :count).by(0)
				end
				it { should have_content("Blad") }
			end

			describe "coment" do
				before do
					fill_in "prod_return_auction_name", with:"Krzeslo"
					fill_in "prod_return_client_name", with:"Michal"
					fill_in "comment", with:""
					expect { click_button "Gotowe" }.to change(ProdReturn, :count).by(0)
				end
				it { should have_content("Blad") }
			end
		end
		describe "submiting form with correct data" do
			before do
				fill_in "prod_return_auction_name", with:"Krzeslo"
				fill_in "prod_return_client_name", with:"Michal"
				expect { click_button "Gotowe" }.to change(ProdReturn, :count).by(1)
			end
			it { should have_content("Dodano nowy ticket") }
		end
	end #"adding new prod_return"
	describe "showing and editing existing prod_return" do
		before { visit root_path }
		describe "on home page" do
			let!(:ret1) { FactoryGirl.create(:prod_return, user:user) }
			let!(:comment1) { FactoryGirl.create(:comment, prod_return:ret1, user:user) }
			let!(:ret2) { FactoryGirl.create(:prod_return, user:user, client_name:"Marek") }
			let!(:comment2) { FactoryGirl.create(:comment, prod_return:ret2, user:user) }
			before { visit root_path }

			it { page.should have_link("#{ret1.id}", href:prod_return_path(ret1)) }
			it { page.should have_button("changeStatus#{ret1.id}")}
			describe "editing status", js:true do
				Capybara.ignore_hidden_elements = false
				before do
					click_button("changeStatus#{ret1.id}")
					click_button("changeStatusOK#{ret1.id}")
				end
				it { ret1.reload.status.should == 2 }
				Capybara.ignore_hidden_elements = true
			end
			describe "editing status - incorrect inputs", js: true do
				Capybara.ignore_hidden_elements = false
				before do
					click_button("changeStatus#{ret1.id}")
					fill_in "content#{ret1.id}", with:""
					expect { click_button "changeStatusOK#{ret1.id}"}.to change(Comment, :count).by(0)
				end
				it { should have_content("blad") }
				specify { ret1.reload.status.should == 1 }
				Capybara.ignore_hidden_elements = true
			end
			describe "editing status - close and delete", js: true do
				Capybara.ignore_hidden_elements = false

				let!(:comments) { ret1.comments }

				before do
					click_button("changeStatus#{ret1.id}")
					select "zamknij_usun", from: "select#{ret1.id}"
					expect { click_button("changeStatusOK#{ret1.id}") }.to change(ProdReturn, :count).by(-1)
				end
				it do
					expect { ProdReturn.find(ret1.id)}.to raise_error(ActiveRecord::RecordNotFound)
				end
				specify do
					comments.each do |com|
						Comments.find_by_id(com.id).should be_nil
					end
				end

				Capybara.ignore_hidden_elements = true
			end
		end
	end #"showing and editing existing prod_return"

	describe "attachment presence" do
		let!(:ret1) { FactoryGirl.create(:prod_return, user:user) }
		let!(:comment1) { FactoryGirl.create(:comment, prod_return:ret1, user:user) }
		let!(:ret2) { FactoryGirl.create(:prod_return, user:user, client_name:"Marek", image: "") }
		let!(:comment2) { FactoryGirl.create(:comment, prod_return:ret2, user:user) }
		before { visit root_path }
		it { should have_link("attmnt#{ret1.id}", href:ret1.image.url) }
		it { should have_button("addAttmnt#{ret2.id}") }
		specify { ret2.image.url.should == "rails.png" }
		describe "adding new attachemnt from home page", js: true do
			before do
				click_button "addAttmnt#{ret2.id}"
				attach_file("file_field#{ret2.id}", Rails.root.to_s+"/spec/images/test.jpg")
				click_button "file_submit#{ret2.id}"
			end
			#it { should have_attached_file(:image) }
			specify { ret2.reload.image.url.should_not == 'rails.png'}
			it { should have_link("attmnt#{ret2.id}", href:ret2.reload.image.url) }
		end
	end #attachment presence

	describe "edit page" do
		let!(:ret1) { FactoryGirl.create(:prod_return, user:user) }
		let!(:comment1) { FactoryGirl.create(:comment, prod_return:ret1, user:user) }
		let(:ret_dup) { ret1.dup }
		before { visit edit_prod_return_path(ret1) }

		it { should have_content("Edytuj zwrot") }

		describe "no changes, just click submit" do
			before { click_button "Gotowe" }
			specify { ret1.client_name.should == ret_dup.client_name }
			specify { ret1.client_msg.should == ret_dup.client_msg }
			specify { ret1.auction_name.should == ret_dup.auction_name }
			specify { ret1.auction_date.should == ret_dup.auction_date }
			specify { ret1.image.url.should == ret_dup.image.url }
		end
		describe "basic fields change" do
			before do
				fill_in "prod_return_client_name", with:"janusz_nowy"
				fill_in "prod_return_client_msg", with: "krzeslo_nowe niewygodne"
				select "July", from:"auction_date_month"
				click_button "Gotowe"
			end
			specify { ret1.reload.client_name.should == "janusz_nowy" }
			specify { ret1.reload.client_msg.should == "krzeslo_nowe niewygodne" }
			specify { ret1.reload.auction_date.month.should == 7 }
		end
		describe "change auction_date to future date" do
			before do
				select "2016", from:"auction_date_year"
				click_button "Gotowe"
			end
			specify { ret1.reload.auction_date.year.should_not == 2016 }
			it { should have_selector('div.alert.alert-error') }
		end
	end
=end


	describe "home_page's tools buttons" do
		let!(:ret1) { FactoryGirl.create(:prod_return, user:user) }
		let!(:comment1) { FactoryGirl.create(:comment, prod_return:ret1, user:user) }
		let!(:ret2) { FactoryGirl.create(:prod_return, user:user, client_name:"Marek", image: "") }
		let!(:comment2) { FactoryGirl.create(:comment, prod_return:ret2, user:user) }
		let!(:ret3) { FactoryGirl.create(:prod_return, user:user, client_name:"Maniek") }
		let!(:comment3) { FactoryGirl.create(:comment, prod_return:ret3, user:user) }
		after(:all) { ProdReturn.destroy_all }
		before { visit root_path }
		it { should have_link("#{ret1.id}", href:prod_return_path(ret1)) }
		describe "tools_edit should redirect to product_return edit page", js: true do
			before do
				check "chbx_#{ret1.id}"
				click_link 'tools_edit'
			end
			it { should have_selector('h3', text:"Edytuj zwrot")}
		end
		describe "tools delete should delete returns", js: true do
			describe "deleting one instance" do
				before do
					check "chbx_#{ret1.id}"
					expect {click_link 'tools_delete'}.to change(ProdReturn, :count).by(-1)
				end
				it { expect {ProdReturn.find(ret1.id)}.to raise_error(ActiveRecord::RecordNotFound)}
			end
		end
		describe "deleting many instances", js: true do
			before do
				check "chbx_#{ret1.id}"
				check "chbx_#{ret2.id}"
				click_link 'tools_delete'
				#expect { click_link 'tools_delete'}.to change(ProdReturn, :count).by(-2)
			end
			it "should not find deleted returns", js: true do
				page.should_not have_link("#{ret1.id}", href: prod_return_path(ret3))
				page.should_not have_link("#{ret2.id}", href: prod_return_path(ret3))
				page.should have_link("#{ret3.id}", href: prod_return_path(ret3))
			end
		end
		describe "deleting attachments", js: true do
			it {should have_link("#{ret1.id}", href: prod_return_path(ret1))}
			before do
				check "chbx_#{ret1.id}"
				check "chbx_#{ret2.id}"
				check "chbx_#{ret3.id}"
				click_link 'tools_delete_att'
			end
			specify do
				page.should have_button "addAttmnt#{ret2.id}"
				ret3.reload.image.url.should == "rails.png" 
			end
		end
	end
end