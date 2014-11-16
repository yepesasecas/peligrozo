class Schedule < ActiveRecord::Base
  before_save :description_organize
  
  belongs_to :movie
  belongs_to :theater

  def description_decorator
    desc = ScheduleDescription.new(self)
    desc.description_decorator
  end

  private

    def description_organize
      self.description = description.rpartition(self.movie.name)[2]
    end

end
