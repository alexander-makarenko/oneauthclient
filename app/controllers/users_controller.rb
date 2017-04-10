class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]
  
  def update
    auth_token = user_params.delete(:auth_token)
    user = User.find_by(auth_token: auth_token)
    if user && user.update(user_params)
      render json: { message: 'User successfully updated' }
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:auth_token, :first_name, :last_name, :email)
    end
end