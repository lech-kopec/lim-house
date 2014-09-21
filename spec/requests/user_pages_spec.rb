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

	describe "profile page" do
		before { visit user_path(user) }

		it { should have_content("#{user.name}") }
	end
end
