OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    ENV['FACEBOOK_APP_ID'],
    ENV['FACEBOOK_SECRET'],
    :iframe => true,
    #:scope => 'publish_actions, email, user_friends'
    # :scope => 'user_about_me, publish_stream, offline_access, publish_actions, friends_likes, email, user_friends, create_event, rsvp_event, user_religion_politics, read_friendlists, friends_religion_politics',
    :scope => 'user_about_me, publish_actions,' +
      'email, user_friends, rsvp_event, read_friendlists',
    :client_options => {
      :site => 'https://graph.facebook.com/v2.0',
      :authorize_url => "https://www.facebook.com/v2.0/dialog/oauth"
    }
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE if Rails.env.development?
end
