class AddPriorityToFieldDefinitions < ActiveRecord::Migration
  def change
    add_column :field_definitions, :priority, :integer
  end
end
