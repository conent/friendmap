class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :otherfriend

      t.timestamps
    end
  end
end
