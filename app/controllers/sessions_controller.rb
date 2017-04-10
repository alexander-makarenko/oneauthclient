class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, except: [:destroy]

  def auth_token_from_credentials
    uri = URI.parse(AUTH_SERVER_URL + AUTH_TOKEN_PROVIDER_PATH)
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    data = { secret_key: AUTH_SECRET_KEY, user: { email: params[:email], password: params[:password] } }
    req.body = data.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
    
    if res.code.to_i == 401
      redirect_to root_path, danger: 'Authentication failed'
    else
      auth_token = JSON.parse(res.body)['auth_token']
      redirect_to authenticate_user_url(auth_token)
    end
  end

  def authenticate_by_token
    uri = URI.parse(AUTH_SERVER_URL + USER_INFO_PROVIDER_PATH + '/' + params[:auth_token])
    req = Net::HTTP::Get.new(uri)
    res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
    auth_hash = JSON.parse(res.body).merge('auth_token' => params[:auth_token])
    user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = user.id
    redirect_to root_path, success: 'Authentication successful'
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end