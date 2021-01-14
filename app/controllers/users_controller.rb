class UsersController < ApplicationController
  before_action :set_unblocked_user, only: [:show]
  skip_before_action :authenticate_user!, only: [:my_stocks]
  before_action :set_update_user, only: [:edit, :update]
  before_action :authorized_user, only: [:update]
  
  def show
    @blocked_users = current_user.active_blocked_user
    @user_stocks = @user.stocks
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
  
  def edit
  end

  def update
    respond_to do |format|
      User.transaction do 
        current_plan = @user.plan
        if @user.update(plan_id: params["user"]["plan_id"])
          unless @user.plan.name == "Free"
            @payment = Payment.new({  email: params["user"]["email"],
                                    token: params[:payment]["token"],
                                    user_id: @user.id,
                                    plan_id: @user.plan.id
                                })
            begin
              @payment.process_payment(@user.plan.price.to_i, @user.plan.name)
              @payment.save
            rescue Exception => e
              flash[:error] = e.message
              @payment.destroy
              @user.plan = current_plan
              @user.save
              redirect_to edit_plan_path(@user) and return
            end
          end
          format.html { redirect_to edit_plan_path(@user), notice: 'Plan was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  end

  private

  def set_unblocked_user
    set_user = User.find_by(id: params[:id])
    if Friendship.current_status?(current_user, set_user)&.blocked?
      render 'blocked_user'
    else
      @user = set_user
    end
  end

  def set_update_user
    @user = current_user
  end

  def authorized_user
    if current_user.email == params["user"]["email"]
      if (@targetuser = User.find_by_email(params[:payment][:email])) && @user.valid_password?(params[:user][:password])
        @user= current_user
      end
    else
      flash[:error] = "Invalid email/password"
      render :edit
    end
  end
end