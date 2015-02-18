module Sources
  class Perucom
    attr_reader :movies, :theaters, :doc, :div_position, :schedules_bool, :schedules
    
    DOC = Nokogiri::HTML(open('http://www.peru.com/entretenimiento/cine'))

    def initialize(args = {})
      @doc = args[:doc] || DOC
      @div_position = args[:perucom_div_position] || 1
      @schedules_bool = args[:schedules] || false

      @movies   = Sources::Perucom::Movie.new(doc: doc, perucom_div_position: div_position).all
      @theaters = Sources::Perucom::Theater.new(doc: doc).all
      @movies   = Sources::Perucom::Schedules.new(movies: movies, theaters: theaters).add if schedules?
    end

    def fetch
      {movies: movies, 
      theaters: theaters}
    end

    private

      def schedules?
        schedules_bool
      end
  end
end