require 'digest/md5'

class User < ActiveRecord::Base

 before_validation :prep_email
 before_save :create_avatar_hash

  attr_accessible :avatarurl, :email, :name, :password, :password_confirmation, :username

  has_secure_password

  has_many :ribbits

  has_many :follower_relationship, class_name: "Relationship", foreign_key: "followed_id"
  has_many :followed_relationship, class_name: "Relationship", foreign_key: "follower_id"
  has_many :followers, through: :follower_relationship
  has_many :followeds, through: :followed_relationship
  
  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness => true 
  validates :email, :presence => true, :uniqueness => true, :format => { with: /^[\w\.+-]+@([\w]+\.)+\w+$/ }

  def following? user 
    self.followeds.include? user
  end

  def follow user 
    Relationship create follower_id: self.id, followed_id: user.id
  end

  private 

  def prep_email 
  	self.email = self.email.downcase if self.email
  end

  def create_avatar_hash
  	self.avatarurl = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
  end

end
