class Movie < ActiveRecord::Base
before_create :get_movie_details

has_many :schedules
has_many :theaters, through: :schedules

private
def get_movie_details
  movie = Fetch::Moviesdb.search self.name
  if not movie.empty?
    details = Tmdb::Movie.detail movie.first.id
    self.overview     = details.overview if overview.nil?
    self.poster_path  = details.poster_path if poster_path.nil?
    self.release_date = details.release_date 
    self.tmdb_id      = details.id
  end
  puts "Creating... #{self.name}"
end
end
