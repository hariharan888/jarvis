class Stock < ApplicationRecord
  has_one :stock_info
  has_many :stock_prices
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :notifications, through: :noticed_events, class_name: "Noticed::Notification"

  validates :name, :ticker, :exchange, :isin, :company_name, presence: true

  after_create :send_notification

  def send_notification
    NewStockNotifier.with(record: self, title: "Stock: #{self.name} created", message: { data: attributes }).deliver
  end
end
