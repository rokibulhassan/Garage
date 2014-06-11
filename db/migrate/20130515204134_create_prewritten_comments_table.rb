class CreatePrewrittenCommentsTable < ActiveRecord::Migration
  def up
    create_table :prewritten_comments do |t|
      t.string  :body_en
      t.string  :body_fr
      # STI
      t.string :type
      t.timestamps
    end
  end

  def down
    drop_table :prewritten_comments
  end
end
