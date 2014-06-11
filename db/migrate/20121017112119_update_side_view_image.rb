class UpdateSideViewImage < ActiveRecord::Migration
  def up
    change_column :side_views, :image, :string, null: false
  end

  def down
    change_column :side_views, :image, :string
  end
end
