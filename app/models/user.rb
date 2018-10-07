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

  def favorite_style
    return "" if ratings.empty?

    averages = {}
    beer_groups = ratings.group_by { |rating| rating.beer.style.name }
    beer_groups.each do |key, value|
      averages[key] = value.reduce(0.0){ |sum, r| sum + r.score } / value.count
    end
    averages.max_by{ |_, v| v }[0]
  end

  def favorite_brewery
    return "" if ratings.empty?

    averages = {}
    brewery_groups = ratings.group_by { |rating| rating.beer.brewery.name }
    brewery_groups.each do |key, value|
      averages[key] = value.reduce(0.0){ |sum, r| sum + r.score } / value.count
    end
    averages.max_by{ |_, v| v }[0]
  end
end
