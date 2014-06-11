class RemoveUserIdFromGalleries < ActiveRecord::Migration
  def up
    remove_column :galleries, :user_id
      end

  def down
    add_column :galleries, :user_id, :integer
  end
end
