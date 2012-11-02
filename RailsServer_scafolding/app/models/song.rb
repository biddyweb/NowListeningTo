class Song < ActiveRecord::Base
	belongs_to :artist
  attr_accessible :artist_id, :title
end
