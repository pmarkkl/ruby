class Style < ApplicationRecord
  has_many :beers

  def average_rating
    return 0 if beers.empty?

    sum = 0
    count = 0
    beers.each do |b|
      if b.average_rating.positive?
        sum += b.average_rating
        count += 1
      end
    end
    return 0 if sum.zero?

    sum / count
  end

  def self.top(count)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |s| -(s.average_rating || 0) }
    sorted_by_rating_in_desc_order[0..count - 1]
  end
end
