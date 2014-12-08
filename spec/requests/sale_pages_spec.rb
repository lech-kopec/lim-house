# encoding: UTF-8
require 'spec_helper'

describe "SalesPages" do
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "Adding new sale" do
		before { visit new_sale_path }

		it { should have_content("Sprzedaż nowa") }
		it { should have_selector("input") }
	end
end 