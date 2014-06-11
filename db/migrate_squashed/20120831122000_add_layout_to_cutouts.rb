class AddLayoutToCutouts < ActiveRecord::Migration
  def change
    add_column :cutouts, :layout, :string
  end
end
