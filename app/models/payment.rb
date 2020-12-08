class Payment < ApplicationRecord
  attr_accessor :card_number, :card_cvc, :expired_month, :expired_year
  
  belongs_to :user
  
  def self.month_options
    month_list = []
    Date::MONTHNAMES.compact.each_with_index { |val, idx| month_list.push([val, idx+1]) }
    month_list
  end

  def self.year_options
    (Date.today.year..(Date.today.year + 10)).to_a
  end

  def process_payment
    customer = Stripe::Customer.create({ email: email, card: token })
    
    Stripe::Charge.create({ customer: customer.id,
                          amount: 10000,
                          description: 'Premium',
                          currency: 'usd'
                        })
  end
end
