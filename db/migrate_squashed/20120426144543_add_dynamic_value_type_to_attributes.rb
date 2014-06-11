class AddDynamicValueTypeToAttributes < ActiveRecord::Migration
  def change
    add_column :attributes, :dynamic_value_type, :string
  end
end
