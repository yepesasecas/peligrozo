ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'database_cleaner'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  DatabaseCleaner.strategy = :transaction

  def sign_in_with_facebook
    click_link "Boton facebook"
  end

  def setup_omniauth_test(status)
    user = case status
    when :config_done then users(:one)
    when :at_genres then users(:two)
    end

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'facebook',
      uid: user.uid,
      info: {
        first_name: "Gaius",
        last_name:  "Baltar",
        email:      "test@example.com"
      },
      credentials: {
        token:      "123456",
        expires_at: Time.now + 1.week
      },
      extra: {
        raw_info: {
          gender: 'male'
        }
      }
    })
  end


  def movie_demo
    [{source: "Demo",
      data:
      {movies:
        [{:name=>"En El Bosque", 
          :value=>730, 
          :poster_path=>"http://cde.peru.com/ima/0/1/0/1/7/1017618/137x197/bosque.jpg", 
          :schedules=>[{
            :theater=>22, :description=>"En el bosque [14][S] 9:30", :price=>"S/.15,5"}, 
            {:theater=>15, :description=>"", :price=>""}], 
          :overview=>"El musical entremezcla argumentos de distintos cuentos de los Hermanos Grimm (Cenicienta, Caperucita Roja, Rapunzel) intentando analizar las consecuencias de los actos y deseos de sus protagonistas. "}],
        theaters: [{
          :name=>"CINEPLANET PRIMAVERA", :value=>22}]}
    }]
  end

  def movie_demo_two
    [{source: "Demo",
      data:{
        movies:[{
          :name=>"En El Bosque", 
          :value=>730, 
          :poster_path=>"http://cde.peru.com/ima/0/1/0/1/7/1017618/137x197/bosque.jpg", 
          :schedules=>[
            {:theater=>15, :description=>"En el bosque [14][S] 9:30", :price=>"S/.15,5"}, 
            {:theater=>22, :description=>"", :price=>""}
          ], 
          :overview=>"El musical entremezcla argumentos de distintos cuentos de los Hermanos Grimm (Cenicienta, Caperucita Roja, Rapunzel) intentando analizar las consecuencias de los actos y deseos de sus protagonistas. "
        }],
        theaters: [{
          :name=>"CINEPLANET SALAVERRY", :value=>15
        }]
      }
    }]
  end


end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
