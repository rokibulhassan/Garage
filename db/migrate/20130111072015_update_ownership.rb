class UpdateOwnership < ActiveRecord::Migration
  def up
    execute 'UPDATE ownerships SET status = \'build_mine\'  WHERE status = \'build mine\''
    execute 'UPDATE ownerships SET status = \'sold_on\'     WHERE status = \'sold on\''
    execute 'UPDATE ownerships SET status = \'owned_since\' WHERE status = \'owned since\''
    execute 'UPDATE ownerships SET owner_name = \'kid_1\' WHERE owner_name = \'kid 1\''
    execute 'UPDATE ownerships SET owner_name = \'kid_2\' WHERE owner_name = \'kid 2\''
  end

  def down
    execute 'UPDATE ownerships SET status = \'build mine\'  WHERE status = \'build_mine\''
    execute 'UPDATE ownerships SET status = \'sold on\'     WHERE status = \'sold_on\''
    execute 'UPDATE ownerships SET status = \'owned since\' WHERE status = \'owned_since\''
    execute 'UPDATE ownerships SET owner_name = \'kid 1\' WHERE owner_name = \'kid_1\''
    execute 'UPDATE ownerships SET owner_name = \'kid 2\' WHERE owner_name = \'kid_2\''
  end
end
