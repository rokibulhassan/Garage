class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.string :thing_type
      t.integer :thing_id
      t.integer :user_id
      t.timestamps
    end
    add_index :followings, [ :thing_type, :thing_id ]
    add_index :followings, :user_id
  end
end
