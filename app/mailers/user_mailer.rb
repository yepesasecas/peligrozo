class UserMailer < ActionMailer::Base
  default from: "notifications@peligrozo.co"

  def new_movies(user)
    @user   = user
    @mail   = 'yepes07@gmail.com'
    @movies = Movie.last_week
    @url    = 'http://www.peligrozo.co'

    mail to: @mail, subject: 'email test'
  end

end
