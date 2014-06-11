class AddActiveLayoutToCollages < ActiveRecord::Migration
  def change
    add_column :collages, :active_layout, :string
  end
end
