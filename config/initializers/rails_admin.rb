RailsAdmin.config do |config|
  
  config.included_models = [
    "Movie", "User", "Genre", "Theater", "Schedule",
    "EliminatedMovie",
    "MovieGenre", "Country", "City"
  ]
  
  config.authorize_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == ENV["ADMIN_USER"] && password == ENV["ADMIN_PASS"]
    end
  end
  
  config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    # export
    # bulk_delete
    show
    edit
    delete
    # show_in_app

    ## With an audit adapter, you can add:
    history_index
    history_show
  end
end
