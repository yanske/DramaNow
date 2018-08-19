class UserDrama < ApplicationRecord
  # Represents an episode that a user is watching
  belongs_to :user
  belongs_to :drama
  has_many :watching_events, dependent: :destroy

  validates :user, presence: true
  validates :drama, presence: true
  validates :episode_number, presence: true, numericality: { only_integer: true }
  validates :episode_length, presence: true, numericality: { only_integer: true }

  validate :unique_user_drama_episode_number, on: :create

  default_scope { order(episode_number: :asc) }

  def new_episode_available?
    return drama.latest_episode > episode_number
  end

  private

  def unique_user_drama_episode_number
    if UserDrama.where(user: self.user, drama: self.drama, episode_number: self.episode_number).exists?
      errors.add(:user, "already watching this episode")
    end
  end
end
