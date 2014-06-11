class OwnershipDateTonumber < ActiveRecord::Migration
  def up
    remove_column :ownerships, :date
    add_column :ownerships, :year, :integer
  end

  def down
    add_column :ownerships, :date, :datetime
    remove_column :ownerships, :year, :integer
  end
end
