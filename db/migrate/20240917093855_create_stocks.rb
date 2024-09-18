class CreateStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :stocks do |t|
      t.string :name, null: false
      t.string :ticker, null: false
      t.string :exchange, null: false
      t.string :isin, null: false
      t.string :company_name, null: false
      t.integer :bse_code
      t.string :nse_code
      t.string :sector

      t.timestamps
    end
  end
end
