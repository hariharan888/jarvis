class CreateStockPrices < ActiveRecord::Migration[7.2]
  def change
    create_table :stock_prices do |t|
      t.references :stock, null: false, foreign_key: true
      t.date :date, null: false
      t.decimal :open, null: false
      t.decimal :high, null: false
      t.decimal :low, null: false
      t.decimal :close, null: false
      t.integer :volume

      t.timestamps
    end
  end
end
