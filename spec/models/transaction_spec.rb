require 'spec_helper'

describe Transaction do
	let(:product) { FactoryGirl.create(:product) }
	let(:client) { FactoryGirl.create(:client) }
	let(:auction) { FactoryGirl.create(:auction, product: product) }

	before do
		@transaction = client.transactions.build(auction_id:auction.id, quantity:1, status: 0)
	end
	subject { @transaction }

	it { should be_valid }
	it { should respond_to(:client_id) }
	it { should respond_to(:auction_id) }
	it { should respond_to(:quantity) }
	it { should respond_to(:status) }

	describe "when one of the ids is not presen" do
		before { @transaction.client_id = nil }
		it { should_not be_valid }
		before { @transaction.auction_id = nil; @transaction.client_id = client.id }
		it { should_not be_valid }
	end

	describe "mass assignment error" do
		it "should_not allow mass assignment to client_id" do
			expect do
				Transaction.new(client_id:client.id, auction_id:auction.id, quantity:1)
			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "quantity" do
		describe "when is lower than or equal to zero" do
			before { @transaction.quantity = -1}
			it { should_not be_valid }
		end
	end
	describe "when status is invalid" do
		before { @transaction.status = -1 }
		it { should_not be_valid }
	end
end
