module Sources
  class Colombiacom
    class Movies
      attr_reader :doc, :movie_class

      def initialize(args)
        p "Colombiacom::Movies"
        @doc = args[:doc]
      end
      
      def get
        doc_movies = doc.css(".menuTopCine>ul>li")[0].css("ul>li>a")
        doc_movies.map do |doc_movie|
          Sources::Colombiacom::Moviem.new(doc_movie: doc_movie).get
        end
      end
    end
  end
end