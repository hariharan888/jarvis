class CreateStockPrices < ActiveRecord::Migration[7.2]
  def change
    create_table :stock_prices do |t|
      t.references :stock, null: false, foreign_key: true
      t.date :date
      t.decimal :open
      t.decimal :high
      t.decimal :low
      t.decimal :close
      t.integer :volume

      t.timestamps
    end
  end
end
