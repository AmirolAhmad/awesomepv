class Post < ActiveRecord::Base
	validates :title, presence: true, length: { minimum: 5 }
	validates :description, presence: true, length: { minimum: 5 }
	validates :youtube_id, presence: true, length: { minimum: 5 }

	DISQUS_SHORTNAME = Rails.env == "development" ? "awesomevideos".freeze : "awesomevideos".freeze

	def self.search(query)
	  where("title LIKE ?", "%#{query}%")
	end

	def to_param
	    [id, title.parameterize].join("-")
	end
end
