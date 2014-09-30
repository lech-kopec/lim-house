require 'spec_helper'

describe "Static pages" do

	subject {page}

	describe "Home page" do
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
			let!(:user) { FactoryGirl.create(:user) }
			let!(:product) { FactoryGirl.create(:product) }

			before do
				sign_in user
				visit root_path
			end

			it "should have products links and descriptions" do
				page.should have_link("#{product.title}", href:product_path(product))
				page.should have_content("#{product.description}")
			end
			it "should have links for editing and deleting products" do
				page.should have_link('Edit', href:edit_product_path(product))
				page.should have_link('Delete')
			end
		end
		describe "for not-signed_in users" do
			#todo
		end
	end

	describe "product show page" do
		#todo
	end
	describe "product edit page" do
		#todo
	end
end
