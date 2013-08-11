class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def find_by_director
    return unless director.present?
    Movie.where(director: director).reject {|m| m == self}
  end

end
