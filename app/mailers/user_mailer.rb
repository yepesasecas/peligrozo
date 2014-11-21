class UserMailer < ActionMailer::Base
  default from: "notifications@peligrozo.co"

  def new_movies(user)
    @user   = user
    @movies = Movie.last_week
    
    mail to: @user.email, subject: 'Ultimas peliculas peligrozas!'
  end

end
