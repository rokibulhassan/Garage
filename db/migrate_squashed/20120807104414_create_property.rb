class CreateProperty < ActiveRecord::Migration
  def change
    create_table :properties_groups do |t|
      t.string :name
      t.integer :position
      t.timestamps
    end

    create_table :properties do |t|
      t.string :name
      t.integer :position
      t.references :properties_group
      t.timestamps
    end

    add_index :properties, :properties_group_id
  end
end
