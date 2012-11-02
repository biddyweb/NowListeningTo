class Post < ActiveRecord::Base
  attr_accessible :date, :song_id, :user_id
end
