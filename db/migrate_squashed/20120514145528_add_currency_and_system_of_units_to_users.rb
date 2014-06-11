class AddCurrencyAndSystemOfUnitsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :currency, :string
    add_column :users, :system_of_units, :string
  end
end
