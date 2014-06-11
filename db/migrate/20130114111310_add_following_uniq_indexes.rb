class AddFollowingUniqIndexes < ActiveRecord::Migration
  def up
    add_index "followings", ["user_id", "thing_type", "thing_id"], name: "index_followings_on_user_id_thing_type_and_thing_id", unique: true
  end

  def down
    remove_index "followings", name: "index_followings_on_user_id_thing_type_and_thing_id"
  end
end
