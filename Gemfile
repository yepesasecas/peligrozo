source 'https://rubygems.org'

ruby '2.2.1'
gem 'rails', '~> 4.2.0'

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
gem 'state_machine', github: 'seuros/state_machine'
gem 'omniauth-facebook', '~> 1.4.0'
gem 'figaro', '~> 1.1.1'
gem 'rails-i18n', '~> 4.0.0'
gem 'sendgrid-ruby'
gem 'rails_admin'
gem 'paper_trail', '~> 4.0.0.beta'
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
