require 'spec_helper'

describe Product do
	before { @prod = Product.new(title:"Prod1",description:"Prod1Descr", price:10.0, status:0) }

	subject { @prod }

	it { should respond_to(:title) }
	it { should respond_to(:description) }
	it { should respond_to(:status) }
	it { should respond_to(:price) }
	it { should respond_to(:quantity) }

	describe "attributes validation" do
		describe "when title is blank" do
			before { @prod.title="" }
			it { should_not be_valid }
		end
		describe "when description is blank" do
			before { @prod.description = "" }
			it { should_not be_valid }
		end
		describe "when price is blank" do
			before { @prod.price = nil }
			it { should_not be_valid }
		end
		describe "when status is blank" do
			before { @prod.status = nil }
			it { should_not be_valid }
		end
		describe "when title is too long" do
			before { @prod.title = "a"*51 }
			it { should_not be_valid }
		end
		describe "when description is too long" do
			before { @prod.title = "a"*500}
			it { should_not be_valid }
		end
		describe "when quantity is nil" do
			before { @prod.quantity = nil }
			it { should_not be_valid }
		end
		describe "when quantity is less than 0" do
			before { @prod.quantity = -1 }
			it { should_not be_valid }
		end
	end
end
