class User < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3 }

  validates :password, length: { minimum: 4 },
                       format: {
                         with: /[A-Z].*\d|\d.*[A-Z]/,
                         message: "must contain one capital letter and number"
                       }

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

  def self.sorted_by_ratings(count)
    sorted = User.all.sort_by{ |u| -(u.ratings.count || 0) }
    sorted[0..count - 1]
  end
end
