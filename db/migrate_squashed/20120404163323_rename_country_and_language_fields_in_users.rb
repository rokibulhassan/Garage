class RenameCountryAndLanguageFieldsInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :country, :country_code
    rename_column :users, :language, :language_code
  end

  def down
    rename_column :users, :country_code, :country
    rename_column :users, :language_code, :language
  end
end
