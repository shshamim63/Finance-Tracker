class StocksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search]
  
  def search
    if params[:stock].blank?
      flash.now[:danger] = 'You have entered an empty string'
    else
      stock_ticker = Stock.new_stock_symbol_lookup(params[:stock])
      @stock = nil
      if stock_ticker
        @stock = Stock.new_from_lookup(stock_ticker)
      else
        @stock = Stock.new_from_lookup(params[:stock])
      end
      flash.now[:danger] = 'You have entered the wrong company name' unless @stock
    end
    respond_to do |format|
      format.js { render partial: 'users/result' }
    end
  end
end