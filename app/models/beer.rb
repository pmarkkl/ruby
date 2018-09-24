class Beer < ApplicationRecord
  include RatingAverage

  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :style, presence: true, length: { minimum: 2, maximum: 50 }

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  def to_s
    "#{name} (#{brewery.name})"
  end
end
