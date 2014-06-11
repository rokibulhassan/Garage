class CreateModifications < ActiveRecord::Migration
  def change
    create_table :modifications do |t|
      t.string :name
      t.references :revision

      t.timestamps
    end
    add_index :modifications, :revision_id
  end
end
