class AddLocaleToFix < ActiveRecord::Migration
  def change
    add_column :fixes, :locale, :string
  end
end
