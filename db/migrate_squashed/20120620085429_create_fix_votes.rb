class CreateFixVotes < ActiveRecord::Migration
  def change
    create_table :fix_votes do |t|
      t.references :fix
      t.references :user
      t.string :value

      t.timestamps
    end
  end
end
