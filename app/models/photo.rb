class Photo < ActiveRecord::Base
  attr_accessible :caption, :file
  has_attached_file :file, styles: {thumb: "100x100#", medium: "350x270>"}

  belongs_to :album
end
