class WatchingEvent < ApplicationRecord
  belongs_to :user_drama

  validates :user_drama, presence: true
  validates :duration, presence: true, numericality: { only_integer: true }

  default_scope { order(duration: :asc) }

  def still_watching?
    return user_drama.episode_length - duration > 5.minutes.to_i
  end
end
