class User < ApplicationRecord
  validates :email,
    presence: true,
    uniqueness: true

  validates :password_digest,
    presence: true

  def self.authenticate(email, password)
    find_by(email: email, password_digest: password)
  end
end