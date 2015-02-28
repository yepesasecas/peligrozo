module Sources
  class Colombiacom
    class Cities
      attr_reader :doc

      def initialize(args)
        @doc = args[:doc] 
      end
      
      def get
        cities = []

        doc_cities = doc.css(".menuTopCine>ul>li")[1].css("ul>li>a")
        doc_cities.each do |doc_cities|
          cities.push({
            name: name(doc_cities),
            value: value(doc_cities)
          })
        end
        cities
      end

      private
      def name(doc_cities)
        doc_cities.children.text
      end

      def value(doc_cities)
        doc_cities.attributes["href"]
          .value
          .split("/")[2]
      end
    end
  end
end