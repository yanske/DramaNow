class User < ApplicationRecord
  validates :key, presence: true, uniqueness: true, length: { is: 6 }
  after_initialize :intialize_unique_key

  private 

  def intialize_unique_key
    self.key ||= SecureRandom.urlsafe_base64[0, 6]
  end
end
