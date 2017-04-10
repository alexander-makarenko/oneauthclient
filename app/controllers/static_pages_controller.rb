class StaticPagesController < ApplicationController  
  def home    
    @auth_form_url = AUTH_SERVER_URL + AUTH_FORM_PATH
  end
end