class Article < ActiveRecord::Base
acts_as_rateable
has_many :comments
  has_attached_file :photo
  belongs_to :user
  ajaxful_rateable :stars=>5, :dimensions=>[:name]

  

  end
