module Factories
  class Genres
    
    def self.update
      genres = Fetch::Moviesdb.genres
      genres.each do |new_genre|
        genre = Genre.find_by tmdb_id: new_genre["id"]
        if genre.nil? 
          Genre.create(name: new_genre["name"], tmdb_id: new_genre["id"])
        end
      end
    end
    
  end
end