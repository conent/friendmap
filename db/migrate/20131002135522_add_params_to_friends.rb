class AddParamsToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :name, :string
    add_column :friends, :surname, :string
    add_column :friends, :isonline, :string
    add_column :friends, :datanumber, :integer, :default => 0, :null => false
    add_column :friends, :imagenumber, :integer, :default => 0, :null => false
    add_column :friends, :lastseen, :timestamp 
    add_column :friends, :latitude, :float, :default => 0, :null => false
    add_column :friends, :longitude, :float, :default => 0, :null => false
  end
end
