require 'spec_helper'

describe "ClientPages" do

=begin
	subject {page}
	let(:client) { FactoryGirl.create(:client) }

	describe "index page" do
		before { visit clients_path }

		describe "as not-signed user" do
			it { should have_content('Lim-House') }
			it { should have_link('Sign in', href: signin_path) }
		end
		describe "as signed_in user" do
			let(:user) { FactoryGirl.create(:user) }
			before(:all) { 30.times { FactoryGirl.create(:client) } }
			after(:all) { Client.delete_all }
			before do
				sign_in user
				visit clients_path
			end
			it { should have_selector('title', text:"Clients list") }
			it { should have_content('Clients list') }
			
			describe "pagination" do
				it { should have_selector('div.pagination') }
				it " should list all clients" do
					Client.paginate(page: 1).first(5).each do |cl|
						page.should have_content(cl.f_name)
						page.should have_content(cl.l_name)
						page.should have_link("#{cl.f_name} #{cl.l_name}", href: client_path(cl))
					end
				end
			end
		end
	end
	describe "show page" do
		#todo
	end
=end
end
