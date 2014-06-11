class MigrationNumbersToString < ActiveRecord::Migration
  def up
    change_column :versions, :transmission_numbers, :string
  end

  def down
    change_column :versions, :transmission_numbers, :integer
  end
end
