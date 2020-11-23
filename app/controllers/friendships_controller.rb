class FriendshipsController < ApplicationController
  before_action :authenticate_user!, :find_user

  def add
    friendship = current_user.friendships.build(friend: @user, status: 'pending')

    if friendship.save
      redirect_back fallback_location: root_path
    end
  end

  def accept
    friendship = current_user.friendships.build(friend: @user, status: 'accepted')

    if friendship.save
      redirect_back fallback_location: root_path
    end
  end

  def reject
    friendship = current_user.friendships.build(friend: @user, status: 'rejected')

    if friendship.save
      redirect_back fallback_location: root_path
    end
  end
  
  def cancelled
    friendship = current_user.friendships.build(friend: @user, status: 'cancelled')

    if friendship.save
      redirect_back fallback_location: root_path
    end
  end
  
  def unfriend
    friendship = current_user.friendships.build(friend: @user, status: 'unfriended')

    if friendship.save
      redirect_back fallback_location: root_path
    end
  end

  def block
    friendship = current_user.friendships.build(friend: @user, status: 'blocked')

    if friendship.save
      redirect_to user_path(current_user)
    end
  end


  def unblock
    friendship = current_user.friendships.build(friend: @user, status: 'unblocked')

    if friendship.save
      redirect_back fallback_location: root_path
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:user_id])
  end
end