class StaticPagesController < ApplicationController
  def home
  	@all = ProdReturn.paginate(page:params[:page], per_page:2)
    @test = ProdReturn.paginate(page:params[:page], per_page:1)
  	@auctioned = Auction.where(status: AuctionsHelper::Status[:open]).paginate(page:params[:page], per_page:2)
  	@auctions_finished = Auction.where(status: ProductsHelper::Product_status[:closed]).paginate(page:params[:page], per_page:5)
  	@waiting = Transaction.where(status:TransactionsHelper::Status[:waiting]).paginate(page: params[:page], per_page:5)
    @payment_done = Transaction.where(status: TransactionsHelper::Status[:payed])
  	@sent = Transaction.where(status: TransactionsHelper::Status[:sent])
    @clean = Product.where(status: 0).paginate(page: params[:page], per_page: 5)
  end

  def help
  end

  private

  	def find_unauctioned_products
  		#todo
  	end
end
