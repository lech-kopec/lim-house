class StaticPagesController < ApplicationController
  def home
  	@all = ProdReturn.paginate(page:params[:page], per_page:10)
    @test = ProdReturn.paginate(page:params[:page], per_page:1)
  end

  def help
  end

  private

  	def find_unauctioned_products
  		#todo
  	end
end
