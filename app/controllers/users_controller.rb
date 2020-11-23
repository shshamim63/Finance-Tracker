class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  skip_before_action :authenticate_user!, only: [:my_stocks]
  def show
    @blocked_users = current_user.active_blocked_user
  end

  def friends
    @friends = current_user.friends
  end

  def my_stocks
    if current_user
      @user_stocks = current_user.stocks
    else
      flash.now[:info] = 'Try our service to get amazing support'
    end
  end

  def search
    if params[:search_params].blank?
      flash.now[:danger] = 'You have entered an empty string'
    else
      searched_users = User.search(params[:search_params])
      @users = current_user.unblocked_users(searched_users)
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