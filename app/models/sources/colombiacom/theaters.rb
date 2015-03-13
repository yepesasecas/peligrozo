module Sources
  module Colombiacom
    class Theaters
      attr_reader :movies

      def initialize(args)
        @movies = args[:movies]
      end

      def rearrange
        theaters = {}
        movies.each do |movie|
          movie[:schedules].each do |schedule|
            theaters[schedule[:theater_value]] = {
              name: schedule.delete(:theater_name).upcase,
              value: schedule.delete(:theater_value),
              city: schedule.delete(:theater_city)
            }
          end
        end
        theaters.values
      end
    end
  end
end