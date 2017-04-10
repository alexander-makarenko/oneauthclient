Rails.application.routes.draw do
  root 'static_pages#home'
  
  post 'auth_callback' => 'sessions#auth_token_from_credentials', as: 'auth_token_from_credentials'
  get  'authenticate/:auth_token' => 'sessions#authenticate_by_token', as: 'authenticate_user'
  delete 'signout', to: 'sessions#destroy', as: 'signout'
  patch 'user_update_callback' => 'users#update'  
end