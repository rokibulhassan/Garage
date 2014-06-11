class AddVersionIdToSideView < ActiveRecord::Migration
  def change
    add_column :side_views, :version_id, :integer
  end
end
