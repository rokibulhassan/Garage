class AddTokenToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :token, :string
  end
end
