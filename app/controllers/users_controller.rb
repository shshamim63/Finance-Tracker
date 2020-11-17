class UsersController < ApplicationController
  def my_stocks
    @user_stocks = current_user.stocks
  end
end