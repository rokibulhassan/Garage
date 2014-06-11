class AddApprovalsCountToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :approvals_count, :integer
    add_column :brands, :disapprovals_count, :integer
    add_column :brands, :approved, :boolean, null: false, default: false
  end
end
