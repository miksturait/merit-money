Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['OMNIAUTH_PROVIDER_KEY'], ENV['OMNIAUTH_PROVIDER_SECRET'],
           {access_type: "offline", approval_prompt: ""}
end
