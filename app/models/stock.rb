class Stock < ApplicationRecord
  
  require 'json'

  has_many :user_stoks
  has_many :users, through: :user_stocks

  validates :name, :ticker, :last_price, presence: true
  
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  def self.new_stock_symbol_lookup(company_name)
    begin
      response = HTTParty.get("http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=#{company_name}&region=1&lang=en&callback=YAHOO.Finance.SymbolSuggest.ssCallback").to_s
      stock_symbol = JSON.parse(response[39...-2])['ResultSet']['Result'][0]['symbol']
    rescue Exception => e
      stock_symbol = nil
    end
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
