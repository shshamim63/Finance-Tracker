class FriendshipsController < ApplicationController
  before_action :authenticate_user!, :find_user

  def add
    friendship = current_user.friendships.build(friend: @user, status: 'pending')

    if friendship.save
      redirect_back fallback_location: root_path
    end
  end
  private

  def find_user
    @user = User.find_by(id: params[:user_id])
  end
end