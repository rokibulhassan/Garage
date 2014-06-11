class AddYearToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :production_year, :string, limit: 4
  end
end
