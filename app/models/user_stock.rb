class UserStock < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  def self.most_added_stocks
    group(:stock_id).select(:stock_id).order("count(*) desc").first(2).map {|rec| rec.stock_id }
  end
end
