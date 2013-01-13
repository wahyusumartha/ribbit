class Ribbit < ActiveRecord::Base
  
  default_scope order: 'created_at DESC'
  belongs_to :user
  attr_accessible :content

  validates :content , :length => { :maximum => 140 }

end
