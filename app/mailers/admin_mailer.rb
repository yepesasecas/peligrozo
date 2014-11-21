class AdminMailer < ActionMailer::Base
  default from: "notifications@peligrozo.co"

  def new_movies
    @user   = User.first
    @email  = 'yepes07@gmail.com'
    @movies = Movie.last_week
    
    mail to: @email, subject: '[ADMIN] Ultimas peliculas peligrozas!'
  end
end
