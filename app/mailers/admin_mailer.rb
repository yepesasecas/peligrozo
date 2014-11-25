class AdminMailer < ActionMailer::Base
  default from: "notifications@peligroso.co"

  def new_movies
    @user   = User.first
    @email  = 'yepes07@gmail.com'
    @movies = Movie.playing_now.last_day
    
    mail to: @email, subject: "#{@movies.count} nuevas peliculas peligrozas!"
  end
end
