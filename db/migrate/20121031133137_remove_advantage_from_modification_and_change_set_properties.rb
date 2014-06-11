class RemoveAdvantageFromModificationAndChangeSetProperties < ActiveRecord::Migration
  def up
    remove_column :modification_properties, :advantage
    remove_column :change_set_properties, :advantage
  end

  def down
    add_column :modification_properties, :advantage, :boolean, :default => true, :null => false
    add_column :change_set_properties, :advantage, :boolean, :default => true
  end
end
