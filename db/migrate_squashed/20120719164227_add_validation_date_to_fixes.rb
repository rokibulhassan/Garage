class AddValidationDateToFixes < ActiveRecord::Migration
  def change
    add_column :fixes, :validated_at, :datetime
  end
end
