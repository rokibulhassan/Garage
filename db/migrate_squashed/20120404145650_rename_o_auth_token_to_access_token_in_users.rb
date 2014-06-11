class RenameOAuthTokenToAccessTokenInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :facebook_oauth_token, :facebook_access_token
  end

  def down
    rename_column :users, :facebook_access_token, :facebook_oauth_token
  end
end
