class User < ApplicationRecord
  validates :key, presence: true, uniqueness: true, length: { is: 6 }
  after_initialize :intialize_unique_key

  private 

  def intialize_unique_key
    # While not unqiue, re-initialize
    while self.key.nil?
      key = SecureRandom.urlsafe_base64[0, 6]
      self.key = key unless User.where(key: self.key).exists?
    end
  end
end
