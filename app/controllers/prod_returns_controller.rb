class ProdReturnsController < ApplicationController

  def new
  	@ret = ProdReturn.new
  end

  def create
    new_date = "#{params[:auction_date][:day]}/#{params[:auction_date][:month]}/#{params[:auction_date][:year]}"
    
    @ret = current_user.prod_returns.build(params[:prod_return])
    
    @ret.auction_date = new_date
    @ret.status = 1
    
    comment_params = { content: "#{params[:comment]}", user_id: current_user.id }
    
    begin
      ProdReturn.transaction do
        @ret.save!
        @com = @ret.comments.create!(comment_params)
        flash[:success] = "Dodano nowy ticket"
        redirect_to root_path
      end
      rescue => e
        @ret = ProdReturn.new
        flash[:error] = "Blad w formularzu"
        render 'new'
        return
    end
  end

  def show
    @ret = ProdReturn.find(params[:id])
  end

  def update
    @comment = Comment.new
    @comment.user_id = params[:prod_return][:user_id]
    @comment.prod_return_id = params[:prod_return][:ret]
    @comment.content = params[:comment][:content]

    @ret = ProdReturn.find(params[:prod_return][:ret])
    @ret.status = params[:prod_return][:status]


  if @ret.save && @comment.save
      flash[:success] = "Zmiany wprowadzono"
      redirect_to root_path
    else
      flash[:error] = "Wystapil blad"
      redirect_to root_path
    end

  end

end
