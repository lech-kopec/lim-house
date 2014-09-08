require 'spec_helper'

describe "Static pages" do
	subject {page}
	describe "Home page" do
		before { visit root_path }

		it "should have the content 'Lim-House'" do
			page.should have_content('Lim-House')
		end
		it "should have title 'Lim-House'" do
			page.should have_selector('title', text:'Lim-House')
		end
	end
end