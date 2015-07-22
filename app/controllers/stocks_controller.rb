class StocksController < ApplicationController
  require 'net/http'
  require 'json'
  require 'csv'

  layout '_stocks.html.erb'
  before_action :authenticate_user!

  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = current_user.following
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    if Stock.check_valid(params[:symbol])
      if Stock.not_exists?(params[:symbol])
        create
      end
      $stock = Stock.find(params[:symbol])
      @input = Stock.get_overview(params)
      if @input === 404
        not_found
      else
        @data = YahooFinance.quotes([params[:symbol]], [:name, :last_trade_price, :ask, :bid, :open, :close, :volume, :market_capitalization, :dividend_yield, :dividend_per_share, :change, :change_in_percent, :last_trade_date])
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: $stock }
        end
      end
    else
      not_found
    end
  end

  def create
    @stock = Stock.new(symbol: params[:symbol], name: YahooFinance.quotes([params[:symbol]], [:name])[0].name)
    @stock.save
  end

  # GET /stocks/1/edit
  def edit
    @stock = Stock.find(params[:symbol])
  end

  # PUT /stocks/1
  # PUT /stocks/1.json
  def update
    @stock = Stock.find(params[:symbol])
    binding.pry
    respond_to do |format|
      if @stock.update_attributes(params[:currentPrice])
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { head :ok }
      else
        if @stock.update_attributes(params[:openingPrice])
          format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
          format.json { head :ok }
        else
          if @stock.update_attributes(params[:closingPrice])
            format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
            format.json { head :ok }
          else
            format.html { render action: 'edit' }
            format.json { render json: @stock.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  def search
    @results = Stock.search(params)['ResultSet']['Result']
    respond_to do |format|
      format.html # search.html.erb
      format.json { render json: @results }
    end
  end

  def watch
    stock = Stock.find(params[:symbol].upcase)
    current_user.watch_stock(stock)
    # TODO : Watch Action
    redirect_to :back
  end

  def unwatch
    stock = Stock.find(params[:symbol].upcase)
    current_user.unwatch_stock(stock)
    # TODO : Unwatch Action
    redirect_to :back
  end
end