Rails.application.configure do

  # Allow Cloud9 connections.
  
  config.hosts << /[a-z0-9]+.c9users.io/
end