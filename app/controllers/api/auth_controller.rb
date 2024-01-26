class Api::AuthController < Api::ApiController
  skip_before_action :authorized, only: [:login, :check]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def login 
      @user = User.find_by!(email: login_params[:email])
      if @user.valid_password?(login_params[:password])
          @token = encode_token(user_id: @user.id)
          render json: {
              user: UserSerializer.new(@user),
              token: @token
          }, status: :accepted
      else
          render json: {message: 'Incorrect password'}, status: :unauthorized
      end
  end

  def check
    render json: 'check'
  end

  private 

  def login_params 
      params.permit(:email, :password)
  end

  def handle_record_not_found(e)
      render json: { message: "User doesn't exist" }, status: :unauthorized
  end
end
