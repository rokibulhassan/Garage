class RemoveUselessColumnsAboutDefaultFigures < ActiveRecord::Migration
  def up
    remove_column :versions, :figure_url
    remove_column :version_vehicle_figures, :default
  end

  def down
    add_column :version_vehicle_figures, :default, null: false, default: false
    add_column :versions, :figure_url, :string
  end
end
