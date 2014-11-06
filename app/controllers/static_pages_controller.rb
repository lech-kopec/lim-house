class StaticPagesController < ApplicationController
  def home
    @all = ProdReturn.paginate(page:params[:page], per_page:10)
    @received = ProdReturn.where(status: ApplicationHelper::ReturnsStatus[:przyjete]).paginate(page:params[:page], per_page:10)
    @ready_to_send = ProdReturn.where(status: ApplicationHelper::ReturnsStatus[:przetworzone]).paginate(page:params[:page], per_page:10)
  	@sent = ProdReturn.where(status: ApplicationHelper::ReturnsStatus[:wyslane]).paginate(page:params[:page], per_page:10)
  end

  def help
  end

end
