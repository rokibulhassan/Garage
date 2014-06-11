class AddDefaultToChangeSets < ActiveRecord::Migration
  def change
    add_column :change_sets, :default, :boolean, default: false
  end
end
