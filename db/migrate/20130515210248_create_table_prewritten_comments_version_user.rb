class CreateTablePrewrittenCommentsVersionUser < ActiveRecord::Migration
  def up
    create_table :prewritten_comments_version_user do |t|
      t.integer :user_id
      t.integer :version_id
      t.integer :prewritten_comment_id
      t.timestamps
    end
  end

  def down
    drop_table :prewritten_comments_version_user
  end
end
