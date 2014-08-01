module Fetch
  module Moviesdb
    def self.search(name)
      ini
      Tmdb::Movie.search(name)
    end

    def self.upcoming
      ini
      Tmdb::Movie.upcoming
    end

    def self.now_playing
      ini
      Tmdb::Movie.now_playing
    end

    def self.prueba
      "probando TMDB Module"
    end

    private
      def self.ini
        Tmdb::Api.key("999e1362be6ce13ac10a05a8122ca9ae")
        Tmdb::Api.language("es")
      end
  end
end