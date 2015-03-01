module Sources
  class Colombiacom
    class MovieN
      attr_reader :name, :value, :cities, :movie_doc
      attr_accessor :poster_path, :schedules, :overview

      DOMAIN = 'http://cine.colombia.com/pelicula/'

      def initialize(args)
        p "ENTRA"
        @name = args[:name]
        @value = args[:value]
        @poster_path = ""
        @schedules = []
        @overview = ""

        @cities = args[:cities]
        @movie_doc = doc(DOMAIN + value)
      end

      def get
        get_overview
        get_poster_path

        {
          name: name,
          value: value,
          poster_path: poster_path,
          schedules: schedules,
          overview: overview
        }
      end

      private
      def get_overview
        overview = @movie_doc.css(".descripcionPeli>p")
      end

      def get_poster_path
        
      end

      def doc(url)
        Nokogiri::HTML(open(url))
      end
    end
  end
  
end