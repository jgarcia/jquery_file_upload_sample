class Album < ActiveRecord::Base
  attr_accessible :description, :title
  
  validates_presence_of :title

  has_many :photos
end
