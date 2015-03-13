module Sources
  module Colombiacom
    class Moviem
      attr_reader :doc_movie
      attr_accessor :poster_path, :schedules, :overview, :movie_cities,
        :name, :value, :movie_details_doc, :youtube_id

      DOMAIN = 'http://cine.colombia.com/pelicula/'

      def initialize(args)
        p "Colombiacom::Moviem"
        @doc_movie = args[:doc_movie]
        @schedules = []
      end

      def get
        get_name
        get_value
        set_movie_details_doc
        get_overview
        get_youtube_id
        get_movie_cities
        get_schedules

        {
          name: name,
          value: value,
          poster_path: poster_path,
          movie_cities: movie_cities,
          schedules: schedules,
          overview: overview,
          trailer: youtube_id
        }
      end

      private
        def get_name
          self.name = doc_movie.children.text.titleize
        end

        def get_value
          self.value = doc_movie.attributes["href"]
            .value
            .split("/")[2]
        end

        def set_movie_details_doc
          self.movie_details_doc = doc(DOMAIN + value)
        end
        
        def get_overview
          begin
            self.overview = movie_details_doc.css(".descripcionPeli>p>span")[0].children.text
          rescue
            p "get_overview issue"
          end
        end

        def get_youtube_id
          begin
            self.youtube_id = movie_details_doc.css(".detallepR>div")[0]
              .children[0]
              .attributes["src"]
              .value
              .split("/embed/")[1]
              .split("?")[0]
          rescue
            p "get_youtube_id"
          end
        end

        def get_movie_cities
          self.movie_cities = movie_details_doc.css(".programacion a").map do |schedule_link|
            schedule_link.attributes["href"].value.split("/")[2]
          end
        end

        def get_schedules
          p "get_schedules"
          movie_cities.each do |movie_city|
            movie_city_doc = doc(DOMAIN + movie_city)
            get_poster_path(movie_city_doc)
            get_movie_city_schedules(movie_city_doc, city: movie_city)
          end
        end

        def get_movie_city_schedules(movie_city_doc, args={})
          p "get_movie_city_schedules"
          begin
            movie_city_doc.css(".programacionListaT>.teatroP").each do |doc_schedule|
              self.schedules.push({
                theater: get_schedule_theater(doc_schedule),
                description: get_schedule_description(doc_schedule),
                theater_name: get_schedule_theater_name(doc_schedule),
                theater_value: get_schedule_theater_value(doc_schedule),
                theater_city: args[:city]
              })
            end
          rescue
            p "get_movie_city_schedules issue"
          end
        end

        def get_schedule_theater(doc_schedule)
          doc_schedule.css(".direccion>.nombreTeatro>a")[0]
            .attributes["href"]
            .value
            .split("/")[2]
        end

        def get_schedule_description(doc_schedule)
          doc_description = doc_schedule.css(".hora")[0]
            .children.last
            .text
          schedule_description_parse(doc_description)
        end

        def schedule_description_parse(doc_description)
          # 3:40 pm - 4:10 pm - 6:30 pm - 7:00 pm - 9:20 pm - 9:50pm
          # Kingsman: el servicio secreto [14][S] 4:40, 7:00, 9:50
          doc_description
            .gsub(" - ", ", ")
            .delete("pm")
            .insert(0, "nombre pelicula [xx] ")
        end

        def get_schedule_theater_name(doc_schedule)
          doc_schedule.css(".direccion>.nombreTeatro>a")[0]
            .children[0]
            .text
        end

        def get_schedule_theater_value(doc_schedule)
          doc_schedule.css(".direccion>.nombreTeatro>a")[0]
            .attributes["href"]
            .value
            .split("/")[2]
        end

        def get_poster_path(movie_city_doc)
          self.poster_path ||= movie_city_doc.css(".programacionArriba>.fl>a>img")[0]
            .attributes["src"]
            .value
        end
        
        def doc(url)
          Nokogiri::HTML(open(url))
        end
    end
  end
end