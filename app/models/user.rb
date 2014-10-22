class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  acts_as_paranoid

  extend FriendlyId #https://github.com/norman/friendly_id

  friendly_id :username, use: [:slugged, :finders, :history]

  has_one :profile, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :profile, update_only: true, allow_destroy: true

  validates :username, :uniqueness => { :case_sensitive => false }

  scope :admin, -> { where(admin: true) }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => username.downcase }]).first
    else
      where(conditions).first
    end
  end
end
