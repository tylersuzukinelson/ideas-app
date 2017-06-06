class User < ApplicationRecord
  has_secure_password

  has_many :likes, dependent: :destroy
  has_many :liked_ideas, through: :likes, source: :idea

  validates_uniqueness_of :email
end
