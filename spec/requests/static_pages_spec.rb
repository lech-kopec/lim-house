require 'spec_helper'

describe "Static pages" do
	subject {page}
	describe "Home page" do
		before do
			visit '/static_pages/home'
		end
		it "should have the content 'Lim-House home page'" do
			it.should have_content('Lim-House home page')
		end
		it "should have title 'Lim-House'" do
			it.should have_selector('title', text:'Lim-House')
		end
	end
end