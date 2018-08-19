class Drama < ApplicationRecord
  include ActiveModel::Dirty

  has_many :user_dramas, dependent: :destroy

  ACCEPTED_SITES = ['dramafever'].freeze

  validates :title, presence: true, format: { with: /\A[a-zA-Z0-9-]+\Z/ }
  validates :site, presence: true, inclusion: { in: ACCEPTED_SITES }
  validates :link, presence: true
  validates :latest_episode, presence: true, numericality: { only_integer: true }
  validates :latest_episode_update, presence: true
  validate :unique_title_and_site, on: :create

  before_validation :update_latest_episode_timestamp

  # Scope for should check based on latest_episode_update

  private

  def unique_title_and_site
    if Drama.where(title: self.title, site: self.site).exists?
      errors.add(:title, "already exists in selected site")
    end
  end

  def update_latest_episode_timestamp 
    self.latest_episode_update = Time.current if latest_episode_changed?
  end
end
