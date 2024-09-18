require 'rails_helper'

require 'rails_helper'

RSpec.describe StockInfo, type: :model do
  it { should belong_to(:stock) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      stock = create(:stock)
      stock_info = StockInfo.new(stock: stock)
      expect(stock_info).to be_valid
    end

    it 'is not valid without a stock' do
      stock_info = StockInfo.new(stock: nil)
      expect(stock_info).to_not be_valid
    end
  end
end
