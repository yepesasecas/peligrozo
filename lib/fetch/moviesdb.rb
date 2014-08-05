module Fetch
  module Moviesdb
    def self.search(name)
      ini
      Tmdb::Movie.search(name)
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

    def self.categories
      ini
      Tmdb::Genre.list
      # http://api.themoviedb.org/3/genre/movie/list?api_key=999e1362be6ce13ac10a05a8122ca9ae&language=ES
    end

    private
      def self.ini
        Tmdb::Api.key("999e1362be6ce13ac10a05a8122ca9ae")
        Tmdb::Api.language("es")
      end
  end
end