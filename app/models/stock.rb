class Stock < ApplicationRecord
  has_many :user_stoks
  has_many :users, through: :user_stocks
  
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  def self.new_from_lookup(ticker_symbol)
    begin
      looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
      new(name: looked_up_stock.company_name, ticker: looked_up_stock.symbol, last_price: looked_up_stock.latest_price)
    rescue Exception => e
      looked_up_stock = nil
    end
  end

  def self.selected_stock_names(selected_ids)
    where(id: selected_ids).map {|rec| rec.ticker}
  end

  def self.popular_ticker_news(ticker_symbols)
    news = []
    ticker_symbols.each do |ticker|
      begin
        recent_stock = StockQuote::Stock.news(ticker, 2)
        news.push(recent_stock)
      rescue Exception => e
        recent_stocks = nil
      end
    end
    news
  end
end
