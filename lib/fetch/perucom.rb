module Fetch
  module Perucom
    require 'open-uri'
    def self.get_movies
      p "Getting movies.."
      movies  = []
      posters = self.get_posters
      doc     = Nokogiri::HTML(open('http://www.peru.com/entretenimiento/cine'))
      
      doc.css('li.list-item').each do |li|
        name  = li.children.text
        value = li.attributes["data"].value.to_i
        if 500 < value
          movie = Movie.new name: name, value: value
          movies.push movie
        end
      end
      movies.each do |movie|
        movie.poster_path = posters[movie.name]
      end
      movies
    end

    def self.get_theaters
      p "Getting Theaters.."
      theaters = []
      doc      = Nokogiri::HTML(open('http://www.peru.com/entretenimiento/cine'))
      doc.css('li.list-item').each do |li|
        name  = li.children.text
        value = li.attributes["data"].value.to_i

        if value < 500
          theater = Theater.new name: name, value: value
          theaters.push theater
        end
      end
      theaters
    end

    def self.create_schedules(movies, theaters)
      p "Getting Schedules.."
      agent = Mechanize.new
      page  = agent.get 'http://www.peru.com/entretenimiento/cine'

      # movies   = [movies.first]
      # theaters = [theaters.first]

      movies.each do |movie|
        theaters.each do |theater|
          form             = page.forms[1]
          form["pelicula"] = movie.value
          form["cine"]     = theater.value
          response         = agent.submit(form)
          noko             = Nokogiri::HTML(response.body)
          address          = noko.css('td.direccion').children.text
          price            = noko.css('td.precio').children.text
          description      = noko.css('td.horario').children.text
          overview         = noko.css('p')[2].children.text
          movie.update_attributes overview: overview

          if not description.empty?
            schedule = Schedule.create movie_id: movie.id, theater_id: theater.id, description: description, price: price
            p "adding schedule.. #{schedule.id}"
          end
        end
      end
    end

    private

      def self.get_posters
        p "Getting posters.."
        doc     = Nokogiri::HTML(open('http://www.peru.com/entretenimiento/cine'))
        posters = {}
        div_listados = doc.css("div.listado_peliculas")
        div_listados.each do |div_listado|
          ul_div = div_listado.children[1]

          ul_div.children.each do |li|
            if li.class == Nokogiri::XML::Element
              figure_div = li.children[1]
              # a_div      = figure_div.children[0] # PRODUCTION
              a_div      = figure_div.children[1] # DEVELOPMENT
              img_div    = a_div.children[1]
              if img_div
                img_attributes = img_div.attributes 
                poster_movie   = img_attributes["alt"].value
                poster_path    = img_attributes["data-original"].value
                posters[poster_movie] = poster_path
                p "poster.. #{poster_movie}:#{poster_path}"
              else
                p "poster.. empty"
              end
            end
          end
        end
        posters
      end

      def self.get_movies_overview(movies, theaters)
        p "Getting Movies Overview.."
        agent = Mechanize.new
        page  = agent.get 'http://www.peru.com/entretenimiento/cine'
        movies.each do |movie|
          theaters.each do |theater|
            form             = page.forms[1]
            form["pelicula"] = movie.value
            form["cine"]     = theater.value
            response         = agent.submit(form)
            noko             = Nokogiri::HTML(response.body)
            overview         = noko.css('p')[2].children.text
            movie.overview   = overview
            p "#{movie.name} - #{theater.name} - #{movie.overview}"
          end
        end
        movies
      end
  end
end