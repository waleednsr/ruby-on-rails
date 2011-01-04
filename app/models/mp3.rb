class Mp3 < ActiveRecord::Base
  has_attached_file :photo
  has_attached_file :image
  belongs_to :user
  #file_column :image
end
