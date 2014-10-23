require 'spec_helper'

describe Comment do
	let!(:user) { FactoryGirl.create(:user) }
	let!(:ret) { FactoryGirl.create(:prod_return, user:user) }

	before { @comment = ret.comments.build(content:"przekazane dalej", user_id: user.id) }
	after(:all) { User.delete_all; ProdReturn.delete_all}

	subject { @comment }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @comment.user_id = nil }
		it { should_not be_valid }
	end
	describe "when prod_return_id is not present" do
		before { @comment.prod_return_id = nil }
		it { should_not be_valid }
	end
	describe "when content is not present" do
		before { @comment.content = "" }
		it {should_not be_valid }
	end
	describe "when content is longer than 200 char" do
		before { @comment.content = "a"*201 }
		it { should_not be_valid }
	end
end
