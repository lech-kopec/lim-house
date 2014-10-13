class StaticPagesController < ApplicationController
  def home
  	@added = Product.where(status: ProductsHelper::Product_status[:not_auctioned]).paginate(page:params[:page], per_page:5)
  	@auctioned = Auction.where(status: AuctionsHelper::Status[:open]).paginate(page:params[:page], per_page:5)
  	@auctions_finished = Auction.where(status: ProductsHelper::Product_status[:closed]).paginate(page:params[:page], per_page:5)
  	@payment_done = Product.where(status: ProductsHelper::Product_status[:payment_done])
  	@sent = Product.where(status: ProductsHelper::Product_status[:sent])
    @clean = Product.where(status: 0).paginate(page: params[:page], per_page: 5)
  end

  def help
  end

  private

  	def find_unauctioned_products
  		#todo
  	end
  	
end
