# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  puts "Initializing OmniAuth"  # Debugging output
  OmniAuth.config.allowed_request_methods = [:post, :get]
  OmniAuth.config.silence_get_warning = true

  # provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
   # provider :google_oauth2, ENV['610509889012'], ENV['am28j817qoer00t3706dh9ogi8anb9f3.apps.googleusercontent.com'], scope: 'email,profile'


  provider :google_oauth2,
         ENV['GOOGLE_CLIENT_ID'],
         ENV['GOOGLE_CLIENT_SECRET'],
         scope: 'email',
         prompt: 'select_account',
         access_type: 'offline'


end



