class User < ActiveRecord::Base
	has_many :posts
  attr_accessible :email, :username
end
