class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :website
      t.string :street
      t.string :zipcode
      t.string :city
      t.string :country_code

      t.timestamps
    end
  end
end
