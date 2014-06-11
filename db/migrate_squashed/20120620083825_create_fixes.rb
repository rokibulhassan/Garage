class CreateFixes < ActiveRecord::Migration
  def change
    create_table :fixes do |t|
      t.string :fixable_type
      t.integer :fixable_id
      t.string :attribute
      t.string :value
      t.integer :approvals_count
      t.integer :disapprovals_count
      t.references :user

      t.timestamps
    end
  end
end
