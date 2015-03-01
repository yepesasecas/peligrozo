module Sources
  class Colombiacom
    attr_reader :movies, :theaters, :cities, :movie_class

    DOC          = Nokogiri::HTML(open('http://cine.colombia.com/'))
    COUNTRY_CODE = "CO"
    
    def initialize(args = {})
      p "Colombiacom"
      @cities = Sources::Colombiacom::Cities.new(doc: DOC).get
      @movies = Sources::Colombiacom::Movies.new(doc: DOC).get
    end

    def fetch
      {movies: movies, cities: cities, theaters: theaters}
    end
    
    def self.country_code
      COUNTRY_CODE
    end
  end
end