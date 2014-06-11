class AddUserIdToVersionProperties < ActiveRecord::Migration
  def change
    add_column :version_properties, :user_id, :integer
  end
end
