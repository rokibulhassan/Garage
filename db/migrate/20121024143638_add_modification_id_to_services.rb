class AddModificationIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :modification_id, :integer
  end
end
