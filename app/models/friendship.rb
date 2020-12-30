class Friendship < ApplicationRecord
  enum status: [ :pending, :accepted, :rejected, :unfriended, :cancelled, :blocked, :unblocked ]

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  validate :check_request_eligibility, on: :create

  def check_request_eligibility
    if  Friendship.current_status?(self.user, self.friend)&.status == 'blocked'
      errors.add(:status, 'You have/are blocked')
    end
  end

  def self.current_status?(user, friend)
    where(user_id: [user, friend], friend_id: [user, friend]).last
  end
end
