class RenameKindInNameInUnitTypes < ActiveRecord::Migration
  def up
    rename_column :unit_types, :kind, :name
  end

  def down
    rename_column :unit_types, :name, :kind
  end
end
