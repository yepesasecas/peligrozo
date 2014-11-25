desc "This task is called by the Heroku scheduler add-on"

task :day_new_movies => :environment do
  puts "Send an email with all new movies from last day"
  
  movies = Movie.playing_now.last_day
  
  unless movies.empty?
    User.all.each do |user|
      UserMailer.new_movies(user, movies).deliver unless user.email.nil?
    end
  end
end
