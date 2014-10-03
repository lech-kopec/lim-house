class AuctionsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @auction = @product.auctions.new
  end
end
