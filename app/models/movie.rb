class Movie < ActiveRecord::Base
before_create :get_movie_details

private
def get_movie_details
  Tmdb::Api.key("999e1362be6ce13ac10a05a8122ca9ae")
  Tmdb::Api.language("es")
  movie = Tmdb::Movie.search name
  if not movie.empty?
    details = Tmdb::Movie.detail movie.first.id
    self.overview     = details.overview if overview.nil?
    self.poster_path  = details.poster_path if poster_path.nil?
    self.release_date = details.release_date 
    self.tmdb_id      = details.id
  end
  puts "movie.rb file: #{self.name}"
end
end
