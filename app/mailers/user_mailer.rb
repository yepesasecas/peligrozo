class UserMailer < ActionMailer::Base
  default from: "notifications@peligroso.co"

  def new_movies(user)
    @user   = user
    @movies = Movie.last_week
    
    mail to: @user.email, subject: "#{@movies.count} nuevas peliculas peligrosas!"
  end

end
