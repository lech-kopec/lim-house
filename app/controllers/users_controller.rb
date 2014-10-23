class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit,:update,:show]
  def show
  	@user = User.find(params[:id])
  end
end
