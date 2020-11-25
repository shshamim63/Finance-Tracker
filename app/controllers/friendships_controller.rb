class FriendshipsController < ApplicationController
  before_action :authenticate_user!, :find_user

  def add
    unless validity_for_friend_request(current_user, @user)
      friendship = current_user.friendships.build(friend: @user, status: 'pending')

      if friendship.save
        redirect_back fallback_location: root_path
      end
    else
      flash.now[:warning] = 'Invalid request'
      redirect_back fallback_location: root_path
    end
  end

  def accept
    if validity_for_accept_request(current_user, @user)
      friendship = current_user.friendships.build(friend: @user, status: 'accepted')

      if friendship.save
        redirect_back fallback_location: root_path
      end
    else
      flash.now[:warning] = 'Invalid request'
      redirect_back fallback_location: root_path
    end
  end

  def reject
    if validate_for_reject(current_user, @user)
      friendship = current_user.friendships.build(friend: @user, status: 'rejected')

      if friendship.save
        redirect_back fallback_location: root_path
      end
    else
      flash.now[:warning] = 'Invalid request'
      redirect_back fallback_location: root_path
    end
  end
  
  def cancelled
    if validate_for_reject(current_user, @user)
      friendship = current_user.friendships.build(friend: @user, status: 'cancelled')

      if friendship.save
        redirect_back fallback_location: root_path
      end
    else
      flash.now[:warning] = 'Invalid request'
      redirect_back fallback_location: root_path
    end
  end
  
  def unfriend
    if current_user.friend?(@user)
      friendship = current_user.friendships.build(friend: @user, status: 'unfriended')

      if friendship.save
        redirect_back fallback_location: root_path
      end
    else
      flash.now[:warning] = 'Invalid request'
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
    if validate_for_unblock(current_user, )
      friendship = current_user.friendships.build(friend: @user, status: 'unblocked')

      if friendship.save
        redirect_back fallback_location: root_path
      end
    else
      flash.now[:warning] = 'Invalid request'
      redirect_back fallback_location: root_path
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:user_id])
  end

  def validity_for_friend_request(user,friend)
    current_status = Friendship.current_status?(user, friend)
    current_status&.accepted? || current_status&.pending? || current_status&.blocked?
  end

  def validity_for_accept_request(user,friend)
    current_status = Friendship.current_status?(user, friend)
    current_status&.pending?
  end

  def validate_for_reject(user, friend)
    current_status = Friendship.current_status?(user, friend)
    (current_status.friend == user && current_status&.pending?) || !current_status&.blocked?
  end

  def validate_for_cancelled(user, friend)
    current_status = Friendship.current_status?(user, friend)
    (current_status.user == user && current_status&.pending?) || !current_status&.blckoed?
  end

  def validate_for_unblock(user, friend)
    current_status = Friendship.current_status?(user, friend)
    current_status&.blocked?
  end
end