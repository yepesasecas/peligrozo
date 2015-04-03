module Factories
  class Theaters
    attr_reader :theaters, :country

    def initialize(args)
      @theaters = args[:theaters]
      @country  = args[:country]
    end
    
    def update
      theaters.each do |n_theater|
        theater = find_or_create_theater(n_theater)
        theater.update name: n_theater[:name], city: find_city(n_theater)
      end
    end

    private
      def find_or_create_theater(n_theater)
        country.theaters.find_by(value: n_theater[:value].to_s) || 
          country.theaters.create(value: n_theater[:value].to_s, name: n_theater[:name])
      end

      def find_city(n_theater)
        country.cities.find_by(value: get_city_value(n_theater))
      end

      def get_city_value(n_theater)
        n_theater[:city] ? "c#{n_theater[:city].split('c')[1]}" : nil
      end
  end
end