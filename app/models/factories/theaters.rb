module Factories
  class Theaters
    attr_reader :theaters

    def initialize(args)
      @theaters = args[:theaters]
    end
    
    def update
      theaters.each do |n_theater|
        theater = find_or_create_theater(n_theater)
        theater.update name: n_theater[:name]
      end
    end

    private
      def find_or_create_theater(n_theater)
        Theater.find_by(value: n_theater[:value]) || 
          Theater.create(value: n_theater[:value], name: n_theater[:name])
      end
  end
end