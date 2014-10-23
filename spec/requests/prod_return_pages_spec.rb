require 'spec_helper'

describe "ProdReturnPages" do

	subject { page }

	let!(:user) { FactoryGirl.create(:user) }
	before do
		sign_in user
	end
	after(:all) { User.delete_all }

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
end