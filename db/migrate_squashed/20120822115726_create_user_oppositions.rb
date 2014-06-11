class CreateUserOppositions < ActiveRecord::Migration
  def change
    create_table :user_oppositions do |t|
      t.integer :user_id
      t.integer :opposer_id

      t.timestamps
    end

    add_index :user_oppositions, [ :user_id, :opposer_id ], unique: true, name: 'by_user_and_opposer'
  end
end
