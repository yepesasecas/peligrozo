class ScheduleDescription
  attr_reader :schedule

  def initialize(schedule)
    @schedule = schedule
  end

  def description
    desc = schedule.description
    desc = remove_comas(desc)
    desc = remove_movie_name(desc)
    desc = split_descriptions(desc)
    desc = separate_description(desc)
    desc = create_hash(desc)
    desc
  end

  def description_decorator
    array = []
    description.each do |e| 
      e[:hours].each do |h|
        array << "#{h}" 
      end
    end
    array
  end

  private
  
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
      desc.map do |d|
        Hash[ 
          characteristics: d[0], 
          hours: d.drop(1)
        ]
      end
    end

end
