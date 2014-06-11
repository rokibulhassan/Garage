class AddDefaultFlagToRevisions < ActiveRecord::Migration
  def change
    add_column :revisions, :default, :boolean, null: false, default: false
  end
end
