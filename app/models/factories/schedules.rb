module Factories
  class Schedules
    attr_reader :movie, :schedules

    def initialize(args)
      @movie = args[:movie]
      @schedules = args[:schedules]
    end
    
    def update
      schedules.each do |n_schedule|
        if n_schedule[:description].empty?
          find_and_delete_schedule(n_schedule)
        else
          schedule = find_or_create_schedule(n_schedule)
          schedule.update(description: n_schedule[:description], 
                          price: n_schedule[:price])
        end
      end
    end

    private

      def find_or_create_schedule(n_schedule)
        theater_id = find_theater_id_by(value: n_schedule[:theater])

        if theater_id
          movie.schedules.find_by(theater_id: theater_id) || 
            movie.schedules.create(theater_id: theater_id,
                                   description: n_schedule[:description])
        end
      end

      def find_and_delete_schedule(n_schedule)
        theater_id = find_theater_id_by(value: n_schedule[:theater])
        if theater_id
          schedule = movie.schedules.find_by(theater_id: theater_id)
          schedule.delete if schedule
        end
      end

      def find_theater_id_by(args)
        theater = find_theater_by(args)
        if theater
          theater.id
        else
          nil
        end
      end

      def find_theater_by(args)
        Theater.find_by(value: args[:value])
      end
  end
end
