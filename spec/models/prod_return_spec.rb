require 'spec_helper'

describe ProdReturn do
	let(:user) { FactoryGirl.create(:user) }

	before { @ret = user.prod_returns.build(auction_name:"krzeslo", auction_date:Time.now, client_name:"Janusz", status:1) }

	subject { @ret }

	it {should respond_to(:auction_name) }
	it {should respond_to(:auction_date) }
	it {should respond_to(:client_name) }
	it {should respond_to(:status) }
	it {should respond_to(:comments) }

	it { should be_valid }

	describe "when auction_name is not present" do
		before { @ret.auction_name = ""}
		it {should_not be_valid }
	end
end
