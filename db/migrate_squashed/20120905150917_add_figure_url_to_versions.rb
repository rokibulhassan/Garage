class AddFigureUrlToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :figure_url, :string
  end
end
