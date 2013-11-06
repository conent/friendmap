class AddLocationToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :location, :string
  end
end
