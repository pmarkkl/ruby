module RatingAverage
  extend ActiveSupport::Concern
  attr :value

  def average_rating
    "#{ratings.average(:score)}"
  end
end