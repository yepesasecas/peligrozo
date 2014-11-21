class UserMailer < ActionMailer::Base
  default from: "notifications@peligroso.co"

  def new_movies(user, movies)
    @user   = user
    @movies = movies
    
    mail to: @user.email, subject: "#{@movies.count} nuevas peliculas peligrosas!"
  end

end
