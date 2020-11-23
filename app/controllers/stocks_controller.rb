class StocksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search]
  def search
    if params[:stock].blank?
      flash.now[:danger] = 'You have entered an empty string'
    else
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = 'You have entered the wrong company name' unless @stock
    end
    respond_to do |format|
      format.js { render partial: 'users/result' }
    end
  end
end