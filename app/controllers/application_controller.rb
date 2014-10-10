class ApplicationController < ActionController::Base
	protect_from_forgery
	include SessionsHelper

	def image_link_for(object)
		link = object.instance_of?(Auction) ? object.product.image_lnk : object.image_lnk
		link = (link.nil? || link.blank?) ? "rails.png" : link
	end

	helper_method :image_link_for
end
