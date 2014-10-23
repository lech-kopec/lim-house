require 'spec_helper'

describe "UserPages" do
	subject {page}
	let(:user) { FactoryGirl.create(:user) }

	describe "home page" do
		before { visit root_path }

		describe "as not-signed user" do
			it { should have_content('Lim-House') }
			it { should have_link('Please sign in', href: signin_path) }
		end
		#describe "as signed_in user" do

	end

	describe "signup page" do
		#todo
	end
	describe "profile page" do
		before do 
			sign_in user
			visit user_path(user)
		end

		it { should have_content("#{user.name}") }
	end
end
