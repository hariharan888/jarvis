class CreateStockInfo < ActiveRecord::Migration[7.2]
  def change
    create_table :stock_infos do |t|
      t.references :stock, null: false, foreign_key: true
      t.decimal :pe_ratio
      t.decimal :pb_ratio
      t.decimal :market_cap
      t.string :sector
      t.decimal :dividend_yield
      t.decimal :eps
      t.decimal :roce
      t.decimal :roe
      t.decimal :debt_to_equity
      t.decimal :book_value
      t.decimal :face_value

      t.timestamps
    end
  end
end
