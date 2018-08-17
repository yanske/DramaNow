class WatchingEvent < ApplicationRecord
  belongs_to :user_drama

  validates :user_drama, presence: true
  validates :duration, presence: true, numericality: { only_integer: true }
end
