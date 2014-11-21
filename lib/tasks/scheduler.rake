desc "This task is called by the Heroku scheduler add-on"

task :update_movies => :environment do
  puts "Updating Movies, Theaters, Genres and Schedules..."
  MoviesFactory.fetch schedules: "true", perucom_div_position: 1
  MoviesFactory.update_genres
  
  AdminMailer.new_movies.deliver
  puts "done."
end

task :update => :environment do
  puts "Updating Movies, Theaters and Genres..."
  MoviesFactory.fetch perucom_div_position: 1
  MoviesFactory.update_genres
  
  AdminMailer.new_movies.deliver
  puts "done."
end

task :update_movies_production => :environment do
  puts "Updating Movies, Theaters, Genre and Schedules in production..."
  MoviesFactory.fetch schedules: "true", perucom_div_position: 0
  MoviesFactory.update_genres
 
  AdminMailer.new_movies.deliver
  puts "done."
end

task :update_production => :environment do
  puts "Updating Movies, Theaters, and Genres in production..."
  MoviesFactory.fetch perucom_div_position: 0
  MoviesFactory.update_genres
  
  AdminMailer.new_movies.deliver
  puts "done."
end