class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.integer :otherfriend

      t.timestamps
    end
  end
end
