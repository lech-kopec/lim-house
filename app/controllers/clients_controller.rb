class ClientsController < ApplicationController
	before_filter :signed_in_user, only: [:index, :show]

	def index
		@clients = Client.paginate(page: params[:page], per_page: 10)
	end
	def show
		@client = Client.find(params[:id])
		@transactions = @client.transactions
	end
end