class AddHideColumnToNewsfeeds < ActiveRecord::Migration
  def up
    add_column :news_feeds, :wait_on_type, :string
    add_column :news_feeds, :wait_on_id, :integer
    add_column :news_feeds, :hidden, :boolean, :default => false
  end

  def down
    remove_column :news_feeds, :wait_on_type
    remove_column :news_feeds, :wait_on_id
    remove_column :news_feeds, :hidden
  end
end
