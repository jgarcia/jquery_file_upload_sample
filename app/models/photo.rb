class Photo < ActiveRecord::Base
  attr_accessible :caption, :file
  validates_presence_of :caption, :file
  
  has_attached_file :file, styles: {thumb: "100x100#", medium: "350x270>"}

  belongs_to :album
end
