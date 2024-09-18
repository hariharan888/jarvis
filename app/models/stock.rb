class Stock < ApplicationRecord
  has_one :stock_info
  has_many :stock_prices
end
