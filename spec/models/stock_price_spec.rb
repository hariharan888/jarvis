require 'rails_helper'

RSpec.describe StockPrice, type: :model do
  it "belongs to a stock" do
    assoc = described_class.reflect_on_association(:stock)
    expect(assoc.macro).to eq :belongs_to
  end
end
