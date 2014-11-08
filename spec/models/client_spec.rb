require 'spec_helper'

describe Client do
=begin
	let(:client) { FactoryGirl.create(:client) }

	subject { client }

	it { should respond_to(:f_name) }
	it { should respond_to(:l_name) }
	it { should respond_to(:address) }

	it { should be_valid }

	describe "when attributes are not present" do
		describe "when first name is blank" do
			before { client.f_name = "" }
			it { should_not be_valid }
		end
		describe "when last name is blank" do
			before { client.l_name = "" }
			it { should_not be_valid }
		end
		describe "when name is too long" do
			before { client.f_name = "a"*51 }
			it { should_not be_valid }
		end
	end
=end
end
 