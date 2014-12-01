require 'spec_helper'
require 'capybara'
require 'capybara/dsl'
include Capybara::DSL

describe "Static pages" do

	subject {page}
	let!(:user) { FactoryGirl.create(:user) }

	describe "Home page" do
		before { visit root_path }
		describe "for not-signed_in users" do
			it { should have_link('Please sign in', href: signin_path) }
		end

		describe "for signed_in user" do
			before do
				sign_in user
				visit root_path
			end
			it { should have_content('zwroty')}
			it { should have_content('zcinka')}
			it { should have_content('sprzedaz inna')}

			it { should_not have_link("Sign in", href:signin_path) }
			it { should_not have_link("Wylogowanie", href:signout_path) }
			#it { sohuld have_link(href:returns_path)}
		end
=begin
	describe " page" do
		before do 
			visit root_path
		end

		it "should have the content 'Lim-House'" do
			page.should have_content('Lim-House')
		end
		it "should have title 'Lim-House'" do
			page.should have_selector('title', text:'Lim-House')
		end
		
		describe "for signed_in user" do
			before do
				sign_in test_user
				visit root_path
			end
			let!(:test_user) { FactoryGirl.create(:user) }
			before(:all) { 15.times { FactoryGirl.create(:prod_return, user: test_user).comments.create(user_id:test_user.id,content:"test")}}
			after(:all) { ProdReturn.delete_all; User.delete_all }

			before { visit root_path }

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
=end
	end
end
