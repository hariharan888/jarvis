class Stock < ApplicationRecord
  has_one :stock_info
  has_many :stock_prices

  validates :name, :ticker, :exchange, :isin, :company_name, presence: true
end
