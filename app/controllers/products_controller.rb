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
  	fix_missing_link

  end

  def edit
  	@product = Product.find(params[:id])
  end

  def update
  	@product = Product.find(params[:id])
  	if @product.update_attributes(params[:product])
  		flash[:success] = "Zmiany zostaly wprowadzone"
  		redirect_to @product
  	else
  		flash.now[:error] = "Zmiany nie zostaly wprowadzone"
  		render 'edit'
  	end
  end
end
