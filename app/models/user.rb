class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true
  validates :username, length: { minimum: 3, maximum: 30 }
  validates :password, format: { with: /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{4,}$/, multiline: true }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships, dependent: :destroy
end
