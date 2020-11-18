class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
  
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
    (user_stocks.count < 2)
  end

  def can_add_stock?(stock_symbol)
    under_stock_limit? && !stock_already_added?(stock_symbol)
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
