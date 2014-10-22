require 'spec_helper'
=begin
describe Auction do
	let(:product) { FactoryGirl.create(:product) }
	before do
		@auction = product.auctions.create!(title:product.title, description:product.description, price:product.price, quantity: 10, status: 1, store: AuctionsHelper::Stores[1])
	end

	subject { @auction }

	it { should respond_to(:title) }
	it { should respond_to :description }
	it { should respond_to :price }
	it { should respond_to(:quantity) }
	it { should respond_to(:status) }
	it { should respond_to(:store) }
	it { should respond_to(:product) }
	it { should respond_to(:product_id) }

	it { should be_valid }

	describe "product_id" do
		it "should not allow access to product_id" do
			expect do
				Auction.new(product_id: product.id)
			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
		describe "when product_id is not present" do
			before { @auction.product_id = nil }
			it { should_not be_valid }
		end
		describe "product_id should belong to correct product" do
			its(:product) { should == product }
		end
	end
	describe "title" do
		describe "when title is not present" do
			before { @auction.title = ""}
			it { should_not be_valid }
		end
		describe "when title is too long" do
			before { @auction.title = "a"*51 }
			it { should_not be_valid }
		end
	end
	describe "quantity" do
		describe "when quantity is not present" do
			before { @auction.quantity = nil }
			it { should_not be_valid }
		end
		describe "when quantity is less than zero" do
			before { @auction.quantity = -1 }
			it { should_not be_valid }
		end
	end
	describe "store" do
		describe "when store not in correct set" do
			before do
				@auction.store = "fake-store"
			end
			it { should_not be_valid }
		end
	end
end
=end