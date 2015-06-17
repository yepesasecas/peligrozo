module Fetch
  module Moviesdb
    def self.search(name)
      ini
      Tmdb::Movie.search(name) || nil
    end

    def self.detail(id)
      ini
      Tmdb::Movie.detail id
    end

    def self.upcoming
      ini
      Tmdb::Movie.upcoming
    end

    def self.now_playing
      ini
      Tmdb::Movie.now_playing
    end

    def self.genres
      ini
      Tmdb::Genre.list["genres"]
      # http://api.themoviedb.org/3/genre/movie/list?api_key=999e1362be6ce13ac10a05a8122ca9ae&language=ES
    end

    def self.trailers(id)
      ini
      Tmdb::Movie.trailers id
    end

    private
      def self.ini
        Tmdb::Api.key(ENV["TMDB_KEY"])
        Tmdb::Api.language("es")
      end
  end
end
