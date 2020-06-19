class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_from_lookup(params[:stock])
      if @stock
        render 'users/my_portfolio'
      else
        flash[:danger] = 'You have entered the wrong company name'
        render 'users/my_portfolio'
      end
    else
      flash[:danger] = 'You have entered an empty string'
      render 'users/my_portfolio'
    end
  end
end