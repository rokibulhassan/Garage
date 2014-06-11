class AddLabelToRevisions < ActiveRecord::Migration
  def change
    add_column :revisions, :label, :string
  end
end
