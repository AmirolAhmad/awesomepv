class Picture < ActiveRecord::Base
  acts_as_paranoid

  extend FriendlyId #https://github.com/norman/friendly_id

  friendly_id :pid, use: [:slugged, :finders, :history]

  belongs_to :user, foreign_key: :user_id

  validates :title, length: { maximum: 240 }, presence: true

  self.per_page = 12

  default_scope -> { order('pictures.created_at DESC') }
  scope :published, -> { where('state = ?', 'published').unscope(:order).order('`pictures`.published_at DESC') }
  scope :featured, -> { where(featured: true) }
  scope :published_only, -> { where('featured IS NOT TRUE') }
  scope :random, -> { unscope(:order).order('RAND()') }

  protected

  def published?
    state == 'published'
  end
end
