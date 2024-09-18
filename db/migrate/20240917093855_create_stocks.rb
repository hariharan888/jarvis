class CreateStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :stocks do |t|
      t.string :name
      t.string :ticker
      t.string :exchange
      t.string :isin
      t.string :company_name
      t.integer :bse_code
      t.string :nse_code
      t.string :sector

      t.timestamps
    end
  end
end
