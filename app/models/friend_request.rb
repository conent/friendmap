class FriendRequest < ActiveRecord::Base
  attr_accessible :otherfriend, :friend_id, :created_at
  
  belongs_to :friend
  validates :friend_id, presence: true
end
