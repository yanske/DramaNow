class Drama < ApplicationRecord
  has_many :user_dramas, dependent: :destroy

  ACCEPTED_SITES = ['dramafever'].freeze

  validates :title, presence: true, format: { with: /\A[a-zA-Z0-9-]+\Z/ }
  validates :site, presence: true, inclusion: { in: ACCEPTED_SITES }
  validates :link, presence: true
  validates :latest_episode, presence: true, numericality: { only_integer: true }
  validate :unique_title_and_site, on: :create

  private

  def unique_title_and_site
    if Drama.where(title: self.title, site: self.site).exists?
      errors.add(:title, "already exists in selected site")
    end
  end
end
