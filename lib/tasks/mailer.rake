desc "This task is called by the Heroku scheduler add-on"

task :week_new_movies => :environment do
  puts "Send an email with all new movies from last week"
  
  User.all.each do |user|
    unless user.email.nil?
      UserMailer.new_movies(user).deliver 
    end
  end
end
