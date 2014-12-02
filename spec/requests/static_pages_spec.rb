require 'spec_helper'
require 'capybara'
require 'capybara/dsl'
include Capybara::DSL

describe "Static pages" do

	subject {page}

	describe "Home page" do
	
		let!(:user) { FactoryGirl.create(:user) }
	
		before { visit root_path }
	
		describe "for not-signed_in users" do
			it { should have_link('Please sign in', href: signin_path) }
		end

		describe "for signed_in user" do
			before do
				sign_in user
				visit root_path
			end
			it { should have_link('Zwroty',href:returns_home_path)}

			it { should_not have_link("Sign in", href:signin_path) }
			it { should have_link("Wylogowanie", href:signout_path) }
		end
	end

	describe "Returns home page" do

		let!(:user) { FactoryGirl.create(:user) }

		describe "for signed_in user" do
			before do
				sign_in user
				visit returns_home_path
			end
			before(:all) do
				15.times { FactoryGirl.create(:prod_return, user: user).comments.create!(content:"test", user_id: user.id) }
			end

			it { page.should have_link('Dodaj nowy ticket zwrotu', href:new_prod_return_path) }
			describe "pagination" do
				it {should have_selector('div.pagination')}
				it "should list all returns" do
					ProdReturn.paginate(page: 1).first(5).each do |ret|
						page.should have_content(ret.auction_name)
						page.should have_link("#{ret.id}", href:prod_return_path(ret))
					end
				end
			end
		end
	end
end
