class StaticPagesController < ApplicationController
  def home
  	render layout: "home"
  end

  def returns_home
  	home_page_records
  end

  def help
  end

end
