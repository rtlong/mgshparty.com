# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_MGSHParty_session',
  :secret      => '42ee1f2ffeb2fc29813a9b25d1fb60609515ce77d3789b1b54921f0835b71c29e68453aa47df40d8de4bc19b3d61a4dc31e70f8026cd3b156afd525639e2ab8a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
