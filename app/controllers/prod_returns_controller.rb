class ProdReturnsController < ApplicationController

  def new
  	@ret = ProdReturn.new
  end

  def create
    new_date = "#{params[:auction_date][:day]}/#{params[:auction_date][:month]}/#{params[:auction_date][:year]}"
    
    @ret = current_user.prod_returns.build(params[:prod_return])
    
    @ret.auction_date = new_date
    @ret.status = 1
    
    comment_params = { content: "#{params[:comment]}" }
    @comment = @ret.comments.build(comment_params)
    @comment.user_id = current_user.id
    
    if @ret.save && @comment.save
      flash[:success] = "Dodano nowy ticket"
      redirect_to root_path
    else
      p @ret.errors
      flash.now[:error] = "Blad w formularzu"
      render 'new'
    end
  end

  def show
    @ret = ProdReturn.find(params[:id])
  end

  def zxc
    p "----------------------------------"
    respond_to do |format|
      format.js
    end
  end

end
