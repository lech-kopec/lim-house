class StaticPagesController < ApplicationController
  def home
  	@added = Product.where(status: ProductsHelper::Product_status[:not_auctioned]).paginate(page:params[:page], per_page:5)

  	@auctioned = Auction.where(status: ProductsHelper::Product_status[:auctioned]).paginate(page:params[:page], per_page:5)

  	@auctions_finished = Auction.where(status: ProductsHelper::Product_status[:auction_finished]).paginate(page:params[:page], per_page:5)
  	@payment_done = Product.where(status: ProductsHelper::Product_status[:payment_done])
  	@sent = Product.where(status: ProductsHelper::Product_status[:sent])
  end

  def help
  end

  private

  	def find_unauctioned_products
  		#todo
  	end
  	
end
