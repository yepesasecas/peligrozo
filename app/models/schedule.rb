class Schedule < ActiveRecord::Base
  #has_paper_trail

  before_save :description_organize

  belongs_to :movie
  belongs_to :theater

  def schedule_description
    ScheduleDescription.new(self)
  end

  private

    def description_organize
      self.description = description.rpartition(self.movie.name)[2]
    end
end
