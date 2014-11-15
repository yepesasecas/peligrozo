class Schedule < ActiveRecord::Base
  before_save :description_organize
  
  belongs_to :movie
  belongs_to :theater

  def description_decorator
    array = []
    ScheduleDescription.new(self).description.each do |e| 
      e[:hours].each do |h| 
        array << "#{h}" 
      end
    end
    array
  end

  private

    def description_organize
      self.description = description.rpartition(self.movie.name)[2]
    end

end
