desc "This task is called by the Heroku scheduler add-on"

task :update_movies => :environment do
  puts "Updating Movies, Theaters, Genres and Schedules..."
  Factories::Movies.update_with_schedules_in_development
  Factories::Genres.update_genres
 
  AdminMailer.new_movies.deliver
  puts "done."
end

task :update => :environment do
  puts "Updating Movies, Theaters and Genres..."
  Factories::Movies.update_in_development
  Factories::Genres.update_genres
  
  AdminMailer.new_movies.deliver
  puts "done."
end

task :update_movies_production => :environment do
  puts "Updating Movies, Theaters, Genre and Schedules in production..."
  Factories::Movies.update_with_schedules_in_production
  Factories::Genres.update_genres
 
  AdminMailer.new_movies.deliver
  puts "done."
end

task :update_production => :environment do
  puts "Updating Movies, Theaters, and Genres in production..."
  Factories::Movies.update_in_production
  Factories::Genres.update_genres
  
  AdminMailer.new_movies.deliver
  puts "done."
end