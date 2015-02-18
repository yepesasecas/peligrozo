module Sources
  class Perucom
    class Movie
      attr_reader :doc, :div_position

      def initialize(args)
        @doc = args[:doc]
        @div_position = args[:perucom_div_position]
      end

      def all
        get_movies
      end

      private
        def get_movies
          p "----- Movies"
          movies = get_movies_from_doc
          add_posters_to_movies(movies)
          movies
        end

        def get_movies_from_doc
          movies = []
          doc.css('li.list-item').each do |li|
            name  = li.children.text
            value = li.attributes["data"].value.to_i
            if 500 < value
              movie =  {name: name.titleize, value: value}
              movies.push movie
            end
          end
          movies
        end

        def add_posters_to_movies(movies)
          posters = get_posters
          movies.each {|movie| movie[:poster_path] = posters[movie[:name]]}
        end

        def get_posters
          p "----- Posters"
          posters = {}
          div_listados = doc.css("div.listado_peliculas")
          div_listados.each do |div_listado|
            ul_div = div_listado.children[1]

            ul_div.children.each do |li|
              if li.class == Nokogiri::XML::Element
                figure_div = li.children[1]

                if ENV["RAILS_ENV"]=="development"
                  a_div = figure_div.children[div_position] #1
                else
                  a_div = figure_div.children[div_position] #0
                end
                
                img_div = a_div.children[1]
                
                if img_div
                  img_attributes = img_div.attributes 
                  poster_movie   = img_attributes["alt"].value.titleize
                  poster_path    = img_attributes["data-original"].value
                  posters[poster_movie] = poster_path
                  p "adding poster  #{poster_movie}:#{poster_path}"
                else
                  p "#### WARNING poster empty"
                end
              end
            end
          end
          posters
        end
    end
  end
end