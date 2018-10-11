class Brewery < ApplicationRecord
  include RatingAverage

  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :year, numericality: { only_integer: true, greater_than: 1039, less_than_or_equal_to: ->(_) { Time.now.year } }

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end
end
