module Factories
  class Movies

    MOVIE_EXCEPTIONS = []

    def self.update(args={})
      sources = Sources::Manager.fetch_movies(args)
      p sources
      self.update_sources(sources)
    end

    def self.update_with_schedules_in_production
      self.update(schedules: true, production: true)
    end

    def self.update_with_schedules_in_development
      self.update(schedules: true, production: false)
    end

    def self.update_in_production
      self.update(production: true)
    end

    def self.update_in_development
      self.update(production: false)
    end

    def self.update_moviee(args)
      country = self.find_country_by code: 'PE'
      self.update_movie(args, country)
    end

    private

    def self.update_sources(sources)
      sources.each do |source|
        country = self.find_country_by code: source[:country_code]
        raise "country doesnt exist!" if country.nil?

        self.update_cities(cities: source[:data][:cities], country: country) unless source[:data][:cities].nil?
        self.update_theaters(theaters: source[:data][:theaters],  country: country)
        self.update_movies(movies: source[:data][:movies], country: country)
      end
    end


    def self.update_movies(args)
      new_movies = []
      movies = args[:movies]

      movies.each do |n_movie|
        next if MOVIE_EXCEPTIONS.include? n_movie[:name]

        movie = self.update_movie(n_movie, args[:country])
        new_movies.push(movie)
        if n_movie[:schedules]
          self.update_movie_schedules(movie: movie, schedules: n_movie[:schedules])
        end
      end
      self.remove_old_movies(new_movies, country: args[:country])
    end

    def self.update_movie(n_movie, country)
      movie = self.find_or_create_movie(n_movie, country: country)

      p "Start <#{movie.name}> #{movie.state}"

      movie.update value: n_movie[:value], poster_path: n_movie[:poster_path]
      movie.country = country
      movie.update_genres
      movie.playing
      movie.save

      p "Start <#{movie.name}> #{movie.state}"

      movie
    end

    def self.update_cities(args)
      Factories::Cities.new(args).update
    end

    def self.update_theaters(args)
      Factories::Theaters.new(args).update
    end

    def self.remove_old_movies(new_movies, args = {})
      remove = Movie.in(country_code: args[:country].code).playing_now - new_movies
      remove.each { |movie| movie.take_out }
    end

    def self.find_or_create_movie(n_movie, args)
      Movie.in(country_code: args[:country].code).find_by(name: n_movie[:name]) ||
        args[:country].movies.create(
          name: n_movie[:name],
          value: n_movie[:value].to_s,
          overview: n_movie[:overview],
          poster_path: n_movie[:poster_path]
        )
    end

    def self.update_movie_schedules(args)
      Factories::Schedules.new(args).update
    end

    def self.find_country_by(args={})
      Country.find_by code: args[:code]
    end
  end
end
