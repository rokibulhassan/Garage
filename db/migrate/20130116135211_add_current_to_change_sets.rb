class AddCurrentToChangeSets < ActiveRecord::Migration
  def change
    add_column :vehicles, :current_change_set_id, :integer
  end
end
