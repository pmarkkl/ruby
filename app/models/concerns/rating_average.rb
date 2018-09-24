module RatingAverage
  extend ActiveSupport::Concern
  attr_reader :value

  def average_rating
    ratings.average(:score)
  end
end
