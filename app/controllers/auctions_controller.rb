class AuctionsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @auction = @product.auctions.new
  end

  def create
    @product = Product.find(params[:auction][:prod_id])
    @auction_params = params[:auction].except "prod_id"
    @missing_params = {"store"=>AuctionsHelper::Stores[(params[:auction][:store]).to_i], "status"=>ProductsHelper::Product_status[:auction]}
    @auction_params.merge! @missing_params
    @auction = @product.auctions.new(@auction_params)

  if @auction.save
      flash[:success] = "success"
      redirect_to root_path
    else
      flash.now[:error] = "error"
      render 'new'
    end
  end  

  def show
    @auction = Auction.find(params[:id])
  end

  def update
    @auction = Auction.find(params[:id])
    @auction.update_attributes(params[:auction])
    flash.now[:success] = "Zmiany zostaly wprowadzone"
    render 'show'
  end

  def destroy
    Auction.find(params[:id]).destroy
    flash[:notice] = "Aukcja usunieta"
    redirect_to root_path
  end
end
