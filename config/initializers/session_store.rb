# Be sure to restart your server when you modify this file.

Rails.application.config.session_store(
  :cookie_store,
  :key => '_msi_directory_session',    # any value
  :secure => Rails.env.production?, # Only send cookie over SSL when in production mode
  :http_only => true # Don't allow Javascript to access the cookie (mitigates cookie-based XSS exploits)
)
