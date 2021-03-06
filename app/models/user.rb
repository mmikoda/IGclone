class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :photo, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :feeds
  has_many :favorites, dependent: :destroy
  mount_uploader :photo, ImageUploader
end
