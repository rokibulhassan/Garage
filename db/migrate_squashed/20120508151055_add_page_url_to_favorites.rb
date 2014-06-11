class AddPageUrlToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :page_url, :string
  end
end
