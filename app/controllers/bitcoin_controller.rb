class BitcoinController < ApplicationController
  layout '_bitcoin.html.erb'
  before_action :authenticate_user!

  # GET /stocks
  # GET /stocks.json
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end