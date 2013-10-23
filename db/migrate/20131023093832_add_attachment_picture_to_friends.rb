class AddAttachmentPictureToFriends < ActiveRecord::Migration
  def self.up
    change_table :friends do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :friends, :picture
  end
end
