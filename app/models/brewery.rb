class Brewery < ApplicationRecord
  include RatingAverage

  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :year, inclusion: { in: 1040..Date.current.year }

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

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
