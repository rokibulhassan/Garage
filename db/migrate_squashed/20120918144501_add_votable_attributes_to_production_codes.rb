class AddVotableAttributesToProductionCodes < ActiveRecord::Migration
  def change
    add_column :production_codes, :pending, :boolean, null: false, default: true
    add_column :production_codes, :rejected, :boolean, null: false, default: false
    add_column :production_codes, :upvotes_count, :integer, null: false, default: 0
    add_column :production_codes, :downvotes_count, :integer, null: false, default: 0
  end
end
