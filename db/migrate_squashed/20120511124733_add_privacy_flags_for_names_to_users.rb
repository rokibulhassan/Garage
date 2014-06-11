class AddPrivacyFlagsForNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name_public, :boolean, default: false, null: false
    add_column :users, :last_name_public, :boolean, default: false, null: false
    add_column :users, :emailing_allowed, :boolean, default: false, null: false
  end
end
