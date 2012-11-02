class Post < ActiveRecord::Base
	belongs_to :user
  attr_accessible :date, :song_id, :user_id
end
