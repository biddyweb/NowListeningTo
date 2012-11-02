class Artist < ActiveRecord::Base
	has_many :songs
  attr_accessible :name
end
