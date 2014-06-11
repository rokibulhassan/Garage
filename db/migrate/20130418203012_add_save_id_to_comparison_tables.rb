class AddSaveIdToComparisonTables < ActiveRecord::Migration
  def up
    add_column :comparison_tables, :save_id, :integer
  end

  def down
    remove_column :comparison_tables, :save_id
  end
end
