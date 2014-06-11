class CreateComparisonTables < ActiveRecord::Migration
  def change
    create_table :comparison_tables do |t|
      t.string :label
      t.references :user

      t.timestamps
    end
    add_index :comparison_tables, :user_id
  end
end
