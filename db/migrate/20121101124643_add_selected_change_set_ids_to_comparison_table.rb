class AddSelectedChangeSetIdsToComparisonTable < ActiveRecord::Migration
  def change
    add_column :comparison_tables, :selected_change_set_ids, :text, default: ""
  end
end
