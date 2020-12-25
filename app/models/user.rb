class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :payments
  belongs_to :plan
  accepts_nested_attributes_for :payments
  
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
  
  has_many :messages
  
  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "anonymous"
  end
  
  def stock_already_added?(stock_symbol)
    stock = Stock.find_by_ticker(stock_symbol)
    return false unless stock
    user_stocks.where(stock_id: stock.id).exists?
  end

  def under_stock_limit?
    (user_stocks.count < self.plan.stock_number)
  end

  def can_add_stock?(stock_symbol)
    under_stock_limit? && !stock_already_added?(stock_symbol)
  end

  def friend?(user)
    Friendship.current_status?(user, self)&.accepted?
  end
  
  def friends
    friends = friendships.map do |friendship|
      friend = friendship.friend
      friend if Friendship.current_status?(self, friend)&.accepted?
    end
    inverse_friends = inverse_friendships.map do |friendship| 
      friend = friendship.user
      friend if Friendship.current_status?(friend, self)&.accepted?
    end
    (friends + inverse_friends).compact.uniq
  end

  def active_blocked_user
    friends = friendships.map do |friendship|
      friend = friendship.friend
      friend if Friendship.current_status?(self, friend)&.blocked?
    end
  end

  def passive_blocked_user
    inverse_friends = inverse_friendships.map do |friendship| 
      friend = friendship.user
      friend if Friendship.current_status?(friend, self)&.blocked?
    end
  end

  def total_blocked_user
    (passive_blocked_user + active_blocked_user).compact.uniq
  end

  def unblocked_users(searched_users)
    blocked_users = self.total_blocked_user
    searched_users - blocked_users
  end

  def self.search(params)
    params.strip!
    searched_users = (find_by_frist_name(params)+ 
                      find_by_last_name(params)+
                      find_by_username(params)+
                      find_by_email(params)
                    ).uniq
    searched_users ? searched_users : nil 
  end

  def self.find_by_frist_name(params)
    matches('first_name', params)
  end

  def self.find_by_last_name(params)
    matches('last_name', params)
  end

  def self.find_by_username(params)
    matches('username', params)
  end

  def self.find_by_email(params)
    matches('email', params)
  end

  def self.matches(field, params)
    User.where("#{field} like?", "%#{params}%")
  end
end
