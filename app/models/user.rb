class User < ActiveRecord::Base

 before_validation :prep_email
 before_save :create_avatar_hash

  attr_accessible :avatarurl, :email, :name, :password, :password_confirmation, :username

  has_secure_password

  has_many :ribbits
  
  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness => true 
  validates :email, :presence => true, :uniqueness => true, :format => { with: /^[\w\.+-]+@([\w]+\.)+\w+$/ }

  private 

  def prep_email 
  	self.email = self.email.downcase if self.email
  end

  def create_avatar_hash
  	self.avatarurl = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
  end

end
