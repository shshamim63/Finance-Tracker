class Friendship < ApplicationRecord
  enum status: [ :pending, :accepted, :rejected, :unfriended, :cancelled, :blocked, :unblocked ]

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  def self.current_status?(user, friend)
    where(user_id: [user, friend], friend_id: [user, friend]).last
  end
end
