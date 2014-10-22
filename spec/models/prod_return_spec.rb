require 'spec_helper'

describe ProdReturn do
	let(:user) { FactoryGirl.create(:user) }

	before { @ret = user.prod_returns.build(auction_name:"krzeslo", auction_date:Date.current, client_name:"Janusz", status:1) }

	subject { @ret }

	it {should respond_to(:auction_name) }
	it {should respond_to(:auction_date) }
	it {should respond_to(:client_name) }
	it {should respond_to(:status) }
	it {should respond_to(:comments) }

	it { should be_valid }

	describe "when user_id in not present" do
		before { @ret.user_id = nil }	
		it { should_not be_valid }
	end
	describe "client name" do
		describe "when is not present" do
			before { @ret.client_name = "" }
			it { should_not be_valid }
		end
		describe "when is too long" do
			before { @ret.client_name = "a"*51 }
			it { should_not be_valid }
		end
	end
	describe "auction" do
		describe "name" do
			describe "when is not present" do
				before { @ret.auction_name = ""}
				it {should_not be_valid }
			end
			describe "when is too long" do
				before { @ret.auction_name = "a"*51}
				it {should_not be_valid }
			end
		end
		describe "when auction_date is set in future" do
			before { @ret.auction_date = Time.now + 1.day }
			it { should_not be_valid }
		end
	end
	describe "status" do
		describe "when is not present" do
			before { @ret.status = nil }
			it {should_not be_valid }
		end
		describe "when is not in corect data set" do
			before { @ret.status = 999 }
			it { should_not be_valid }
		end
	end

	describe "adding comments to prod_returns" do
		before { @ret.save }
		let!(:comment_1) { FactoryGirl.create(:comment, user: user, prod_return: @ret) }
		let!(:comment_2) { FactoryGirl.create(:comment, user: user, prod_return: @ret) }
		it "should have new comments in descending order-newest first" do
			@ret.comments.should == [comment_2,comment_1]
		end
	end
	describe "comments should be deleted after deleting return" do
		#todo
	end
end
