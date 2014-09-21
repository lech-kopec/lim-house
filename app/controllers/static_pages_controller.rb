class StaticPagesController < ApplicationController
  def home
  	@added = Product.where(status: ProductsHelper::Product_status[:added])
  	@auctioned = Product.where(status: ProductsHelper::Product_status[:auction])
  	@auctions_finished = Product.where(status: ProductsHelper::Product_status[:auction_finished])
  	@payment_done = Product.where(status: ProductsHelper::Product_status[:payment_done])
  	@sent = Product.where(status: ProductsHelper::Product_status[:sent])
  end

  def help
  end
end
