class ApplicationController < ActionController::Base
	protect_from_forgery
	include SessionsHelper

	def image_link_for(object)
		link = object.instance_of?(Auction) ? object.product.image_lnk : object.image_lnk
		link = (link.nil? || link.blank?) ? "rails.png" : link
	end

	def home_page_records
		@all = ProdReturn.where("status != 99").paginate(page:params[:page], per_page:10)
		@received = ProdReturn.where(status: ApplicationHelper::ReturnsStatus[:przyjete]).paginate(page:params[:page], per_page:10)
    	@ready_to_send = ProdReturn.where(status: ApplicationHelper::ReturnsStatus[:przetworzone]).paginate(page:params[:page], per_page:10)
    	@cash_back = ProdReturn.where(status: ApplicationHelper::ReturnsStatus[:zwrot_gotowki]).paginate(page:params[:page], per_page:10)
    	@exchange = ProdReturn.where(status: ApplicationHelper::ReturnsStatus[:wymiana]).paginate(page:params[:page], per_page:10)
  		@sent = ProdReturn.where(status: ApplicationHelper::ReturnsStatus[:wyslane]).paginate(page:params[:page], per_page:10)
  	end

	helper_method :image_link_for, :home_page_records
end
