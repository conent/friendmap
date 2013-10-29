class Friend < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :fid,
  					:remember_me, :name, :surname, :isonline, :datanumber, :imagenumber, :lastseen, :latitude, :longitude, :picture
  
  # validate
  validates :surname, :name, :email, :password, :password_confirmation, presence: true, :on => :create

  # attr_accessible :title, :body

  has_attached_file :picture, styles: { medium: "256x256>", small: "128x128>", navbar: "35x35>"},
                              url:"/listimages/:style/:normalized_picture_file_name.png",
                              path:":rails_root/public/listimages/:style/:normalized_picture_file_name.png"
  validates_attachment :picture, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                                 size: { less_than: 5.megabytes }
  has_many :friendships, :dependent => :destroy
  has_many :friend_requests, :dependent => :destroy


  Paperclip.interpolates :normalized_picture_file_name do |attachment, style|
    attachment.instance.normalized_picture_file_name
  end

  def normalized_picture_file_name
    "user_#{self.id}"
  end

    after_post_process :after_post_process

   def after_post_process
      if (Friend.find("#{self.id}").imagenumber == nil)
        Friend.find("#{self.id}").update_attributes(:imagenumber => 1)
      else
        add= Friend.find("#{self.id}").imagenumber + 1
        Friend.find("#{self.id}").update_attributes(:imagenumber => add)
      end
    end
end