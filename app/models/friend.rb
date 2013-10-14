class Friend < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
  					:remember_me, :name, :surname, :isonline, :datanumber, :imagenumber, :lastseen, :latitude, :longitude
  
  # validate
  validates :surname, :name, :email, :password, :password_confirmation, presence: true


  # attr_accessible :title, :body

  has_many :friendships, :dependent => :destroy
  has_many :friend_requests, :dependent => :destroy
end
