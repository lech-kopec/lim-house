require 'spec_helper'
=begin
describe "AuctionPages" do
	
	let(:user) { FactoryGirl.create(:user) }
	let!(:product) { FactoryGirl.create(:product) }
	before do
		sign_in user
		visit root_path
	end

	subject { page }
	describe "creating new auction" do
		before { click_link "Auction"}
		it { should have_selector("title",text:"Add new auction") }
		describe "submiting form with invalid info" do
			let(:empty_title) { "" }
			before do
				fill_in "auction_title", with: empty_title
			end
			it do
				expect { click_button "Submit" }.should raise_error(ActiveRecord::RecordInvalid)
			end
		end
		describe "submiting form with valid info" do
			it "should create auction with default values" do
				expect { click_button "Submit"}.to change(Auction,:count).by(1)
			end
			describe "submiting with non-default values" do
				let(:new_title) { "new_title" }
				let(:new_descr) { "new_descr" }
				let(:new_price) { 222 }
				let(:new_status) { 2 }
				let(:new_quantity) { 222 }
				let(:new_store) { "lim-trade2" }
				before do
					fill_in "auction_title", with: new_title
					fill_in "auction_description", with: new_descr
					fill_in "auction_price", with: new_price
					click_button "Submit"
				end
				specify { Auction.count.should == 1}
				specify { product.auctions.count.should == 1}
				let(:new_auction) { product.auctions.first }
				specify do
					new_auction.title == new_title
					new_auction.price == new_price
					new_auction.status == new_status
					new_auction.quantity == new_quantity
				end
			end
		end
	end

	describe "auction show page" do
		#todo
	end
end
=end