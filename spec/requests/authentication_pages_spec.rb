require 'spec_helper'

describe "Authentication" do
	subject {page}
	
	describe "Sign in page" do
		before { visit signin_path }
		it { should have_content('Sign In') }

		describe "with invalid login info" do
			before { click_button('Sign in') }
			it { should have_selector('title', text:'Sign in') }
			it { should have_selector('div.alert.alert-error', text:'Invalid') }
		end
		describe "with valid login info" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Email", with: user.email
				fill_in "Password", with: user.password
				click_button "Sign in"
			end
			it { should have_content(user.name) }
			it { should have_link('Uzytkownik', href: user_path(user)) }
			it { should have_link('Wylogowanie', href: signout_path) }
			it { should_not have_link('Sign in', href: signin_path) }

			describe "followed by sign out" do
				before { click_link "Wylogowanie" }
				it { should have_content('Welcome') }
				it { should have_link("Sign in", href: signin_path) }
				it { should_not have_link('Uzytkownik', href: user_path(user)) }
				it { should_not have_link('Wylogowanie', href: signout_path) }
			end
		end
	end
end
