class ProductsController < ApplicationController
	#before_filter signed_in_user

  def show
  	@prod = Product.find(params[:id])
  end
end
