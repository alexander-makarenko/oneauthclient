class ApplicationController < ActionController::Base
  include SessionsHelper

  # the secret key issued to this website
  AUTH_SECRET_KEY = 'bdd6329e667da077d05893fd068ce3c5ca168858'
  # the URL of the auth server
  AUTH_SERVER_URL = 'http://localhost:3000/'
  # the path of the remote login form on the auth server
  AUTH_FORM_PATH = 'login_remote'
  # the path on the auth server for submitting the credentials (the secret key
  # and the user's email/password) and getting an auth token
  AUTH_TOKEN_PROVIDER_PATH = 'users/authenticate'
  # the path on the auth server for submitting the auth_token and getting the
  # details about the user (name, email, etc.)
  USER_INFO_PROVIDER_PATH = 'users/get_info'

  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger
end