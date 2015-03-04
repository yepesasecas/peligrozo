module Sources
  class Manager

    SOURCES = [Sources::Colombiacom]

    def self.fetch_movies(args ={})
      response = []
      self.sources.each { |source| response.push(self.fetch_source(source, args)) }
      response
    end

    def self.fetch_source(source, args = {})
      { source:       source.to_s, 
        data:         source.new(args).fetch, 
        country_code: source.country_code
      }
    end

    def self.sources
      SOURCES
    end
  end
end