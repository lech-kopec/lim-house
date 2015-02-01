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
		if params[:term]
			search = Product.find(:all, conditions:['title LIKE ?',"%#{params[:term]}%"])
			@result = search.map { |pr| Hash[id: pr.id, label: pr.title, name: pr.title]}
		else
			@prod = Product.find(params[:id])
		end
		respond_to do |format|
			format.html	
		format.json {
				render json: @result.to_json
			}
		end
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
