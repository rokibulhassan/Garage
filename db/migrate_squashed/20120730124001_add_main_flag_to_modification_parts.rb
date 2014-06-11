class AddMainFlagToModificationParts < ActiveRecord::Migration
  def change
    add_column :modification_parts, :main, :boolean, null: false, default: false
  end
end
