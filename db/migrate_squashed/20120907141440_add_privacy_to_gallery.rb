class AddPrivacyToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :privacy, :string, :default => 'public'
  end
end
