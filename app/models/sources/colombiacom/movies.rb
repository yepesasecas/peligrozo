module Sources
  class Colombiacom
    class Movies
      attr_reader :doc

      def initialize(args)
        @doc = args[:doc]
      end
      
      def get
        movies = []

        doc_movies = doc.css(".menuTopCine>ul>li")[0].css("ul>li>a")
        doc_movies.each do |doc_movie|
          movies.push({
            name: name(doc_movie),
            value: value(doc_movie)
          })
        end

        movies
      end

      private
      def name(doc_movie)
        doc_movie.children.text
      end

      def value(doc_movie)
        doc_movie.attributes["href"]
          .value
          .split("/")[2]
      end
    end
  end
end