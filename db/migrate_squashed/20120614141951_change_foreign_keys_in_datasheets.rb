class ChangeForeignKeysInDatasheets < ActiveRecord::Migration
  def up
    add_column :data_sheets, :model_id, :integer
    add_index :data_sheets, :model_id

    add_column :data_sheets, :production_code_id, :integer
    add_index :data_sheets, :production_code_id

    add_column :data_sheets, :generation_id, :integer
    add_index :data_sheets, :generation_id
  end

  def down
    remove_column :data_sheets, :model_id
    remove_index :data_sheets, :model_id

    remove_column :data_sheets, :production_code_id
    remove_index :data_sheets, :production_code_id

    remove_column :data_sheets, :generation_id
    remove_index :data_sheets, :generation_id
  end
end
