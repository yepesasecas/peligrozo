module Sources
  class Perucom
    class Theater
      attr_reader :doc

      def initialize(args)
        @doc = args[:doc]
      end

      def all
        get_theaters
      end

      private
        def get_theaters
          p "----- Theaters"
          theaters = get_theaters_from_doc
          theaters
        end

        def get_theaters_from_doc
          theaters = []
          doc.css('li.list-item').each do |li|
            name  = li.children.text
            value = li.attributes["data"].value
            # value = li.attributes["data"].value.to_i

            if value.to_i < 500
              theater = {name: name, value: value}
              theaters.push theater
            end
          end
          theaters
        end
    end
  end
end