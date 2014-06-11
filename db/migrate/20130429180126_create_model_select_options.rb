class CreateModelSelectOptions < ActiveRecord::Migration
  def up
    create_table :model_select_options do |t|
      t.references :model
      t.string :name
      t.text :options
      t.timestamps
    end
  end

  def down
    drop_table :model_select_options
  end
end
