class AddAddressToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :address, :string
  end
end
