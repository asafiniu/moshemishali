class Video < ActiveRecord::Base
  attr_accessible :description, :title, :url, :typename, :image_url

  def self.by_type(typename)
  	Video.where("typename == ?",typename)
  end
end
