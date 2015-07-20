class Exchange < ActiveRecord::Base
  self.primary_key = 'exchange_id'

  attr_accessor :name, :exchange_id

  has_one :exchange_id, dependent: :destroy
  has_one :name
  has_many :stocks

  def to_param
    symbol.parameterize
  end
end