require 'spec_helper'
include Capybara::DSL
include Capybara::RSpecMatchers

describe "ProductPages" do
	
=begin
	subject { page }

	let!(:user) { FactoryGirl.create(:user) }
	let!(:product) { FactoryGirl.create(:product) }
	
	before { sign_in user }

	describe "New product page" do
		before do
			visit new_product_path
		end
		it { should have_selector('title', text:"Add new product")}
		it { should have_selector('h3', text:"Add new product") }

		describe "add new product with invalid info" do
			it "should not create new product" do
				expect { click_button "Submit" }.not_to change(Product,:count)
			end
		end
	end

	describe "Editing product" do

		before do
			visit edit_product_path(product)
			@prod_backup = product.dup
		end
		it { should have_selector('title', text: 'Edit product') }
		it { page.should have_content('Edit product page') }
		it { find(:xpath, "//img[@class='img_class']/@src").text.should match /rails.png/ }

		describe "with invalid information" do
			before do
				fill_in "product_title", with:""
				fill_in "product_price", with: 10
				click_button "Submit"
			end
			it { should have_content('error') }
			specify { product.reload.title == @prod_backup.title }
		end

		describe "with valid new info" do
			let(:new_title) { "new_test_title" }
			let(:new_price) { product.price+10 }
			before do
				fill_in "product_title", with: new_title
				fill_in "product_price", with: new_price
				select 'auction', from: "product_status"
				click_button "Submit"
			end
			it { should have_selector('title', text:"#{product.reload.title}") }
			it { should have_content("#{new_title}")}
			it { should have_content("#{new_price}")}
			it { should have_content("auction")}
		end
	end
=end
end