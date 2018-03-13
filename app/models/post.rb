class Post < ApplicationRecord
	self.per_page = 10
	acts_as_votable
end
