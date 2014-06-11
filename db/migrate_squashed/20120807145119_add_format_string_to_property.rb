class AddFormatStringToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :format_string, :string
  end
end
