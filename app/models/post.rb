class Post < ActiveRecord::Base
	validates :title, presence: true, length: { minimum: 5 }
	validates :description, presence: true, length: { minimum: 5 }
	validates :youtube_id, presence: true, length: { minimum: 5 }
	validates :user_id, presence: true

	belongs_to :user

	self.per_page = 24

	DISQUS_SHORTNAME = Rails.env == "development" ? "awesomevideos".freeze : "awesomevideos".freeze

	default_scope -> { order('posts.created_at DESC') } #add `` to posts when in local
	scope :featured, -> { where(featured: true) }
	scope :popular, -> { unscope(:order).order('posts.view_count DESC').limit(5) } #add `` to posts when in local
	scope :latest, -> { order('posts.created_at DESC').limit(5) } #add `` to posts when in local

	scope :random, -> { unscope(:order).order('RANDOM()') } #change RANDOM to RAND when in local

	def self.search(query)
	  where("title LIKE ?", "%#{query}%")
	end

	def to_param
	    [id, title.parameterize].join("-")
	end
end
