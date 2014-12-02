require 'spec_helper'

describe Product do
	let!(:prod) { FactoryGirl.create(:product) }
	subject { prod }
	it { should be_valid }

	it { should respond_to(:title) }
	it { should respond_to(:purchase_net_euro) }
	it { should respond_to(:buy_now_gross) }
	it { should respond_to(:delivery_cost) }
	it { should respond_to(:delivery_dhl_gross) }

	describe "attributes validation" do
		describe "when title is blank" do
			before { prod.title="" }
			it { should_not be_valid }
		end
		describe "when title is too long" do
			before { prod.title = "a"*151 }
			it { should_not be_valid }
		end
		describe "prices validation" do
			describe "when purchase_net is blank" do
				before { prod.purchase_net_euro = nil }
				it { should_not be_valid }
			end
			describe "when buy_now_gross is blank" do
				before { prod.buy_now_gross = nil }
				it { should_not be_valid }
			end
			describe "when delivery_cost is blank" do
				before { prod.delivery_cost = nil }
				it { should_not be_valid }
			end
			describe "when delivery_dhl_gross is blank" do
				before { prod.delivery_dhl_gross = nil }
				it { should_not be_valid }
			end
			describe "when purchase_net_euro is negative" do
				before { prod.purchase_net_euro = -1.0 }
				it { should_not be_valid }
			end
			describe "when buy_now_gross is negative" do
				before { prod.buy_now_gross = -1.0 }
				it { should_not be_valid }
			end
			describe "when delivery_cost is negative" do
				before { prod.delivery_cost = -1.0 }
				it { should_not be_valid }
			end
			describe "when delivery_dhl_gross is negative" do
				before { prod.delivery_dhl_gross = -1.0 }
				it { should_not be_valid }
			end
		end
	end
end
