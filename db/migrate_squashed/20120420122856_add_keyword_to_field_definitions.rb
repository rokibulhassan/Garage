class AddKeywordToFieldDefinitions < ActiveRecord::Migration
  def change
    add_column :field_definitions, :keyword, :string
  end
end
