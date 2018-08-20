class Drama < ApplicationRecord
  include ActiveModel::Dirty

  has_many :user_dramas, dependent: :destroy

  DRAMAFEVER = 'dramafever'
  ACCEPTED_SITES = [DRAMAFEVER].freeze

  validates :title, presence: true, format: { with: /\A[a-zA-Z0-9-]+\Z/ }
  validates :site, presence: true, inclusion: { in: ACCEPTED_SITES }
  validates :link, presence: true
  validates :latest_episode, presence: true, numericality: { only_integer: true }
  validates :latest_episode_update, presence: true
  validate :unique_title_and_site, on: :create

  before_validation :update_latest_episode_timestamp

  scope :active, -> { where('latest_episode_update > ? ', DateTime.now - 35.days) }

  def link_to_episode(episode_number)
    case site
    when DRAMAFEVER
      return link_to_dramafever_episode(episode_number)
    end
  end

  def pretty_title
    self.title.gsub('-', ' ').titleize.strip
  end

  private

  def link_to_dramafever_episode(episode_number)
    # URL format: https://www.dramafever.com/drama/[drama #]/[episode #]/[drama-slug]/
    # Find index of / between [episode #], and replace with episode_number
    split_link = link.split('/')
    split_link[5] = episode_number
    split_link.join('/') + '/'
  end

  def unique_title_and_site
    if Drama.where(title: self.title, site: self.site).exists?
      errors.add(:title, "already exists in selected site")
    end
  end

  def update_latest_episode_timestamp 
    self.latest_episode_update = Time.current if latest_episode_changed?
  end
end
