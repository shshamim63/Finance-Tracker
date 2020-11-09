class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def stock_already_added?(stock_symbol)
    stock = Stock.find_by_ticker(stock_symbol)
    return false unless stock
    user_stocks.where(stock_id: stock.id).exist?
  end

  def under_stock_limit?
    (user_stocks.count < 2)
  end

  def can_add_stock?(stock_symbol)
    under_stock_limit? && !stock_already_added?(stock_symbol)
  end
end