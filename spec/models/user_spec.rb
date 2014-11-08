require 'spec_helper'

describe User do
	#before {user = User.new(name:"test1", email:"testmail1@example.com",password:"passwd",password_confirmation:"passwd")}
	#subject { user }
	let!(:user) { FactoryGirl.create(:user) }
	subject { user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:remember_token) }
	it { should be_valid }

	describe "validate attributes" do
		describe "name presence" do
			before {user.name=''}
			it { should_not be_valid }
		end
		describe "email presence" do
			before { user.email = "" }
			it { should_not be_valid }
		end
		describe "remember_token is not blank" do
			before { user.save }
			its(:remember_token) {should_not be_blank}
		end
		describe "when name is too long" do
			before { user.name = "a"*51 }
			it { should_not be_valid }
		end
		describe "when email format is invalid" do
			it "should_not be_valid" do
				addresses = %w[test test@test test,test test@test,tr]
				addresses.each do |address|
					user.email = address
					user.should_not be_valid
				end
			end
		end
		describe "when email is already taken" do
			before do
				user_with_duplicate_email = user.dup
				user_with_duplicate_email.email = user.email.upcase
			end
			it do
				expect { user_with_duplicate_email.save!.to raise_error(ActiveRedord::Error) }
			end
		end
	end
	describe "validate password" do
		describe "when password is not present" do
			before {user.password=""}
			it { should_not be_valid }
		end
		describe "when password_confirmation is null" do
			before { user.password_confirmation=nil}
			it { should_not be_valid }
		end
		describe "when password and password_confirmation are mismatch" do
			before { user.password = "mismatch"}
			it {should_not be_valid }
		end
		describe "when password is too short" do
			before { user.password = "a"*5}
			it { should_not be_valid }
		end
	end
	describe "return value of authenticate method" do
		before { user.save }
		let(:found_user) { User.find_by_email(user.email) }
		describe "with valid password" do
			it { should == found_user.authenticate(user.password) }
		end
		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }
			it { should_not == user_for_invalid_password }
			specify { user_for_invalid_password.should be_false }
		end
	end
end
