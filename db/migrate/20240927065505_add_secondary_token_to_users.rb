class AddSecondaryTokenToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :secondary_token, :string
    add_index :users, :secondary_token, unique: true
  end
end
