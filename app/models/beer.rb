class Beer < ApplicationRecord
  include RatingAverage

  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :style, presence: true, length: { minimum: 2, maximum: 50 }

  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  def to_s
    "#{name} (#{brewery.name})"
  end

  def self.top(count)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating || 0) }
    sorted_by_rating_in_desc_order[0..count - 1]
  end
end
