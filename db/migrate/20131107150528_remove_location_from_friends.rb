class RemoveLocationFromFriends < ActiveRecord::Migration
  def up
    remove_column :friends, :location
  end

  def down
    add_column :friends, :location, :string
  end
end
