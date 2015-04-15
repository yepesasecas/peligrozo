source 'https://rubygems.org'

#ruby '2.1.3'
gem 'rails', '4.1.8'

gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'haml'
gem 'themoviedb', '0.0.22'
gem 'nokogiri'
gem 'mechanize'
gem 'state_machine'
gem 'koala' #añadido por luis
gem 'omniauth-facebook', '1.4.0'
gem 'fb_graph', :git => "git://github.com/nov/fb_graph.git" #añadido por luis
gem 'fb_graph2' # añadido por luis
gem 'figaro'
gem 'rails-i18n', '~> 4.0.0'
gem 'sendgrid-ruby'
gem 'rails_admin'
gem 'paper_trail', '~> 4.0.0.beta'
gem 'tzinfo-data' #añadido por luis
gem 'country_select', github: 'stefanpenner/country_select'


group :development do
  gem 'spring'
  gem 'guard-minitest'
end

group :test do
  gem 'shoulda'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'mocha'
end

group :development, :test  do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'unicorn'
  gem 'rails_12factor'
end
