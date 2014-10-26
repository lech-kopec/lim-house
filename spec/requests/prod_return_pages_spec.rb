require 'spec_helper'


describe "ProdReturnPages" do
	subject { page }

	let!(:user) { FactoryGirl.create(:user) }
	before do
		sign_in user
	end

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
	end
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
		end
	end
end