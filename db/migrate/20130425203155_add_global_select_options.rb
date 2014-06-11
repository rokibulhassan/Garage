class AddGlobalSelectOptions < ActiveRecord::Migration
  def up
    create_table :global_select_options do |t|
      t.string :vehicle_type
      t.string :name
      t.text :options
      t.timestamps
    end
  end

  def down
    drop_table :global_select_options
  end
end
