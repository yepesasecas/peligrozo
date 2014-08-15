desc "This task is called by the Heroku scheduler add-on"
task :update_movies => :environment do
  puts "Updating Movies..."
  MoviesFactory.fetch schedules: "true", perucom_div_position: 1
  puts "done."
end
task :update => :environment do
  puts "Updating Movies..."
  MoviesFactory.fetch perucom_div_position: 1
  puts "done."
end

task :update_movies_production => :environment do
  puts "Updating Movies in production..."
  MoviesFactory.fetch schedules: "true", perucom_div_position: 0
  puts "done."
end
task :update_production => :environment do
  puts "Updating Movies in production..."
  MoviesFactory.fetch perucom_div_position: 0
  puts "done."
end

task :update_genres => :environment do
  puts "Updating Genres..."
  MoviesFactory.update_genres
  puts "done."
end