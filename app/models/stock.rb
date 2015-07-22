class Stock < ActiveRecord::Base
  self.primary_key = :symbol
  attr_accessor :name, :color

  belongs_to :user
  belongs_to :exchange
  has_one :name
  has_one :color

  after_update { |stock| logger.info "Stock #{stock.symbol} updated" }
  validates :symbol, presence: true

  def to_param
    symbol.parameterize
  end

  def get_icon
    if Rails.application.assets.find_asset(symbol).nil?
      return 'logos/' + symbol + '.png'
    else
      return Rails.application.assets.find_asset(symbol).pathname
    end
  end

  def self.not_exists?(symbol)
    self.find(symbol)
    false
  rescue
    true
  end

  def self.check_valid(symbol)
    uri = URI.encode('http://ichart.yahoo.com/table.csv?s=' + symbol + get_year_codes)
    body = Net::HTTP.get(URI.parse(uri)).to_s
    !body.include? '404 Not Found'
  end

  def self.search(params)
    base_url = 'http://d.yimg.com/autoc.finance.yahoo.com/autoc'
    url = "#{base_url}?query=#{URI.encode(params[:search])}&callback=YAHOO.Finance.SymbolSuggest.ssCallback"
    response = open(url).read.sub!('YAHOO.Finance.SymbolSuggest.ssCallback(', '')
    data = JSON.parse(response.chop)

    if data.has_key? 'Error'
      raise 'web service error'
    end

    return data
  end

  def self.get_year_codes
    fromstring = '&a=' + (Date.today.month.to_int - 1).to_s + '&b=' + Date.today.day.to_s + '&c=' + (Date.today.year.to_int - 1).to_s
    tostring = '&d=' + (Date.today.month.to_int - 1).to_s + '&e=' + Date.today.day.to_s + '&f=' + Date.today.year.to_s
    return fromstring + tostring + '&g=d&ignore=.csv'
  end

  def self.get_overview(params)
    uri = URI.encode('http://ichart.yahoo.com/table.csv?s=' + params[:symbol] + get_year_codes)
    body = Net::HTTP.get(URI.parse(uri)).to_s
    if body.include? '404 Not Found'
      @input = 404
    else
      csv = CSV.new(body, :headers => true, :header_converters => :symbol, :converters => [:all])

      # TODO: Use fields of more value
      dates = []
      highs = []
      lows = []

      csv.each do |row|
        dates << row[0] # column 1
        highs << row[2] # column 3
        lows << row[3] # column 4
      end

      input = []
      i = 0
      until i >= dates.length do
        input << ['new Date(' + dates[i] + ')', highs[i], lows[i]]
        i += 1
      end
      return input
    end
  end
end