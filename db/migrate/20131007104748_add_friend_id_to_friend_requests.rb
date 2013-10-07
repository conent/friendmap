class AddFriendIdToFriendRequests < ActiveRecord::Migration
  def change
    add_column :friend_requests, :friend_id, :integer
    add_index :friend_requests, :friend_id
  end
end
