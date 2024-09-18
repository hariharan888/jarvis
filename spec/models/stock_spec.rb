require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { should have_one(:stock_info) }
  it { should have_many(:stock_prices) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:ticker) }
  it { should validate_presence_of(:exchange) }
  it { should validate_presence_of(:isin) }
  it { should validate_presence_of(:company_name) }
end
