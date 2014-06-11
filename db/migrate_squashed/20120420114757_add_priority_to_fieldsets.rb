class AddPriorityToFieldsets < ActiveRecord::Migration
  def change
    add_column :fieldsets, :priority, :integer, default: 0
  end
end
