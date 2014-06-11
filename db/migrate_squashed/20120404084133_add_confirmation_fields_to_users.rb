class AddConfirmationFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmed, :boolean, null: false, default: false
    add_column :users, :confirmed_ad, :datetime
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmation_received_at, :datetime
  end
end
