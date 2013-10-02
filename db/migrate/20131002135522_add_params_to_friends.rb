class AddParamsToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :name, :string
    add_column :friends, :surname, :string
    add_column :friends, :isonline, :string
    add_column :friends, :datanumber, :integer
    add_column :friends, :imagenumber, :integer
    add_column :friends, :lastseen, :timestamp
    add_column :friends, :latitude, :float
    add_column :friends, :longitude, :float
  end
end
