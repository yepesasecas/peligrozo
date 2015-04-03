module Factories
  class Cities
    attr_reader :raw_cities, :country

    def initialize(args)
      @country    = args[:country]
      @raw_cities = args[:cities]
    end

    def update
      raw_cities.each do |raw_city|
        city = find_or_create_city(raw_city)
      end
    end

    private
      def find_or_create_city(raw_city)
        country.cities.find_by(value: raw_city[:value]) || 
          country.cities.create(name: raw_city[:name], value: raw_city[:value])
      end
  end
end