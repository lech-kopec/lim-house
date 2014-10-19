class CommentsController < ApplicationController
  def new
  end

  def create
  	@comment = Comment.new
  	@comment.user_id = params[:user_id]
  	@comment.prod_return_id = params[:ret]
  	@comment.content = params[:content]

  	@ret = ProdReturn.find(params[:ret])
  	@ret.status = params[:status]

  	if @ret.save && @comment.save
  		flash[:success] = "Zmiany wprowadzono"
  		redirect_to root_path
  	else
  		flash[:error] = "Wystapil blad"
  		redirect_to root_path
  	end
  end
end
