desc "This task is called by the Heroku scheduler add-on"
task :update_movies => :environment do
  puts "Updating Movies..."
  MoviesFactory.fetch schedules: "true"
  puts "done."
end
task :update => :environment do
  puts "Updating Movies..."
  MoviesFactory.fetch
  puts "done."
end