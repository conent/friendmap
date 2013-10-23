class Friend < ActiveRecord::Base
  attr_accessor :fid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :fid,
  					:remember_me, :name, :surname, :isonline, :datanumber, :imagenumber, :lastseen, :latitude, :longitude, :picture
  
  # validate
  validates :surname, :name, :email, :password, :password_confirmation, presence: true


  # attr_accessible :title, :body

  has_attached_file :picture, styles: { medium: "320x240>", small: "256x256>", navbar: "35x35>"},
                              url:"/listimages/:style/:basename.:extension",
                              path:":rails_root/public/listimages/:style/:basename.:extension"
  validates_attachment :picture, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                                 size: { less_than: 5.megabytes }
  has_many :friendships, :dependent => :destroy
  has_many :friend_requests, :dependent => :destroy

  before_save :change_file_name


  def self.current_friend
    Thread.current[:current_friend]
  end

  def self.current_friend=(fid)
    Thread.current[:current_friend] = fid
  end
 

private

  def change_file_name
    if (Friend.current_friend!=nil)
      extension = File.extname(picture_file_name).downcase
      self.fid= Friend.current_friend.id.to_s
      self.picture_file_name = fid.concat(".png")  
    end
    
  end
end
