class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :about]

  def index
    require 'json'

    @plans = Plan.all
    ids = UserStock.most_added_stocks
    stocks_ticker = Stock.selected_stock_names(ids)
    @popular_stock_news = Stock.popular_ticker_news(stocks_ticker)
  end

  def about
  end
end
