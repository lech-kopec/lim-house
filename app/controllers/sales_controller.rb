class SalesController < ApplicationController
	def new
		@sale = Sale.new
		@client = Client.new
	end

	def create
		sale_params = params[:sale].merge({status:1})
		client_params = params[:client]
		@client = Client.new(client_params)

		begin
			Sale.transaction do
				@client.save!
				@client.sales.create!(sale_params)
				flash[:success] = "Operacja udana"
				redirect_to sales_path
			end
		rescue => e
			@sale = Sale.new
			flash[:error] = "Blad w formularzu"
			render 'new'
			return
		end
	end

	def show
		@prod = Product.find_by_id(params[:product_id])
		respond_to do |format|
			format.html
			format.js
		end
	end

	def index
		@sales = Sale.all.paginate(page:params[:page], per_page: 10)
	end
end