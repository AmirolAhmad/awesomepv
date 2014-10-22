class Video < ActiveRecord::Base
  acts_as_paranoid

  extend FriendlyId #https://github.com/norman/friendly_id

  friendly_id :vid, use: [:slugged, :finders, :history]

  belongs_to :user, foreign_key: :user_id

  validates :title, length: { maximum: 240 }, presence: true
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :youtube_id, presence: true, uniqueness: true

  self.per_page = 12

  default_scope -> { order('videos.created_at DESC') }
  scope :published, -> { where('state = ?', 'published').unscope(:order).order('`videos`.published_at DESC') }
  scope :featured, -> { where(featured: true) }
  scope :published_only, -> { where('featured IS NOT TRUE') }
  scope :random, -> { unscope(:order).order('RAND()') }

  after_create :send_video_email

  protected

  def published?
    state == 'published'
  end

  def send_video_email
    VideoMailer.video_email(self.user).deliver
 end
end
