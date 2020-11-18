class UsersController < ApplicationController
  
  def friends
    @friends = current_user.friends
  end

  def my_stocks
    @user_stocks = current_user.stocks
  end

  def search
    @users = User.search(params[:search_params])
  end
end