class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  
  def show
  end

  def friends
    @friends = current_user.friends
  end

  def my_stocks
    @user_stocks = current_user.stocks
  end

  def search
    if params[:search_params].blank?
      flash.now[:danger] = 'You have entered an empty string'
    else
      @users = User.search(params[:search_params])
      flash.now[:danger] = 'No match found' if @users.blank?
    end
    respond_to do |format|
      format.js { render partial: 'users/userslist' }
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end
end