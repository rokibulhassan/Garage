class AddVotableAttributesToModels < ActiveRecord::Migration
  def change
    add_column :models, :pending, :boolean, null: false, default: true
    add_column :models, :rejected, :boolean, null: false, default: false
    add_column :models, :upvotes_count, :integer, null: false, default: 0
    add_column :models, :downvotes_count, :integer, null: false, default: 0
  end
end
