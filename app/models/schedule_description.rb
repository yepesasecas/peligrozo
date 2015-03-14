class ScheduleDescription
  attr_reader :schedule

  def initialize(schedule)
    @schedule = schedule
  end

  def to_a
    description
  end

  private
    def description
      begin
        desc = schedule.description
        desc = remove_comas(desc)
        desc = remove_movie_name(desc)
        desc = split_descriptions(desc)
        desc = separate_description(desc)
        
        hash = create_hash(desc)
        hash = order_hash(hash)
        hash = set_tags(hash)
        hash
      rescue
        {}
      end
    end
  
    def remove_comas(desc)
      desc.delete(",")
    end

    def remove_movie_name(desc)
      "[#{desc.partition('[')[2]}"
    end

    def split_descriptions(desc)
      desc.split('|')
    end

    def separate_description(desc)
      desc.map { |e| e.split(" ") }
    end

    def create_hash(desc)
      array = []
      
      desc.map do |d|
        d.drop(1).each do |hour|
          array << { characteristics: d[0], hours: hour, date: DateTime.strptime("#{hour}pm -0500", "%l:%M%p %z") }
        end
      end
      
      array
    end

    def order_hash(hash)
      hash.sort_by{ |v| v[:date] } 
    end

    def set_tags(hash)
      now = DateTime.now.in_time_zone("Bogota")
      first_coming = nil
    
      hash.each do |schedule|
        if now.hour < schedule[:date].hour || 
          (now.hour == schedule[:date].hour && now.min <= schedule[:date].min)
            schedule[:coming] = true

            if first_coming.nil? || 
              validate_hours_and_minutes(schedule[:date], first_coming[:date])
                first_coming = schedule
            end
        end
      end
      
      first_coming[:first_coming] = true if first_coming.present?
      hash
    end

    def validate_hours_and_minutes(schedule, first_coming)
      if schedule.hour < first_coming.hour
        true
      elsif schedule.hour == first_coming.hour && schedule.min <= first_coming.min
        true
      else
        false
      end
    end
end
