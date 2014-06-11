class AddAcceptedToVersionProperties < ActiveRecord::Migration
  def up
    add_column :version_properties, :accepted, :boolean
    VersionProperty.reset_column_information
    VersionProperty.update_all :accepted => true
  end

  def down
    remove_column :version_properties, :accepted
  end
end
