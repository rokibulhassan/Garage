class AddOpenToFixesToDataSheets < ActiveRecord::Migration
  def change
    add_column :data_sheets, :open_to_fixes, :boolean, null: false, default: false
  end
end
