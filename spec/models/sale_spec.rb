require 'spec_helper'

describe Sale do
	let(:sale) { FactoryGirl.create(:sale) }

	subject { sale }

	it { should respond_to(:title) }
	it { should respond_to(:price) }
	it { should respond_to(:quantity) }
	it { should respond_to(:status) }

	describe "when title is blank" do
		before { sale.title = nil }
		it { should_not be_valid }
	end
	describe "when title is too long" do
		before { sale.title = "a"* 151 }
		it { should_not be_valid }
	end
	describe "when price is ltoe 0" do
		before { sale.price = 0 }
		it { should_not be_valid }
	end
	describe "when quantity is ltoe 0" do
		before { sale.quantity = -1.2; }
		it { should_not be_valid }
	end
	describe "when status does not belong to correct set" do
		before { sale.status = 666 }
		it { should_not be_valid }
	end
end
