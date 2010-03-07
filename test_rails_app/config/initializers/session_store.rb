# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_test_rails_app_session',
  :secret      => '23e67dd067b9ea76d4fe85c2e956345dbbde0adf660aa8304916621f4b699e77f84899030be4b3dfa0ba31db3b2df411ccba301cbb47bdd4518693ed73a77d92'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
