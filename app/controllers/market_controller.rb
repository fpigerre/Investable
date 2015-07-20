class MarketController < ApplicationController
  layout '_markets.html.erb'
  before_action :authenticate_user!

  # GET /stocks
  # GET /stocks.json
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end