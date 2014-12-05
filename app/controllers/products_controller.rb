class ProductsController < ApplicationController
	#before_filter signed_in_user

  def new
  	@product = Product.new
  end

  def create
  	@product = Product.new(params[:product])
  	@product.status = 1
  	if @product.save
  		flash[:success] = "New product added"
  		redirect_to root_path
  	else
  		flash.now[:error] = "adding unsuccessful"
  		render 'new'
  	end
  end

  def show
  	@prod = Product.find(params[:id])
  end

  def edit
  	@product = Product.find(params[:id])
  end

  def index
    @products = Product.all.paginate(page: params[:page], per_page: 20)
  end

  def update
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:notice] = "Produkt usuniety"
    redirect_to root_path
  end
end
