class AddChildIdsToNewsFeeds < ActiveRecord::Migration
  def up
    add_column :news_feeds, :child_ids, :text
  end

  def down
    remove_column :news_feeds, :child_ids
  end
end
