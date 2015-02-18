module Sources
  class Perucom
    class Schedules
      attr_reader :agent, :page, :movies, :theaters

      def initialize(args)
        @movies   = args[:movies]
        @theaters = args[:theaters]
        @agent    = Mechanize.new
        @page     = agent.get 'http://www.peru.com/entretenimiento/cine'
      end
    
      def add
        movies_with_schedules = get_schedules
        movies_with_schedules
      end

      private
        def get_schedules
          p "----- Schedules"
          new_movies = movies

          new_movies.each do |movie|
            movie[:schedules] = [] 
            theaters.each do |theater|
              begin
                p "#{movie[:value]} - #{theater[:value]}"
                form             = page.forms[1]
                form["pelicula"] = movie[:value]
                form["cine"]     = theater[:value]
                response         = agent.submit(form)
                noko             = Nokogiri::HTML(response.body)
                address          = noko.css('td.direccion').children.text
                price            = noko.css('td.precio').children.text
                description      = noko.css('td.horario').children.text
                overview         = noko.css('p')[2].children.text
                
                movie[:overview] ||= overview
                movie[:schedules].push({theater: theater[:value], description: description, price: price})
              rescue Exception => e
                p "#### EXCEPTION movie: #{movie[:value]} - Theater: #{theater[:value]}"
              end
            end
          end
          new_movies
        end
    end
  end
end