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

  def bitfinex
    respond_to do |format|
      format.html # bitfinex.html.erb
    end
  end

  def bitstamp
    respond_to do |format|
      format.html # bitstamp.html.erb
    end
  end

  def btcchina
    respond_to do |format|
      format.html # btcchina.html.erb
    end
  end

  def okcoin
    respond_to do |format|
      format.html # okcoin.html.erb
    end
  end
end