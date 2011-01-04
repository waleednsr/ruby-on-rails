# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_graph_session',
  :secret      => '7d8cc606b5e3e9c3d5874002bc097e3e13f505def8020989625d5636323d7c97b46b000f5f040cba684e22fa12ad677124fc15f6e6034f17a3d8faac3825ff8e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
