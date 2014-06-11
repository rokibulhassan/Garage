class AddProductionCodeIdToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :production_code_id, :integer
    add_index :versions, :production_code_id
  end
end
