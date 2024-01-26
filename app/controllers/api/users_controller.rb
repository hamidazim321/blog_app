class Api::UsersController < Api::ApiController
  skip_before_action :authorized, only: [:create]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
  def create
    user = User.create!(user_params)
    @token = encode_token(user_id: user.id)
    render json: {
      user: UserSerializer.new(user),
      token: @token
    }, status: :created
  end

  private

  def user_params
    params.permit(:name, :email, :password, :bio, :password_confirmation, :photo)
  end

  def handle_record_not_found
    render json: { message: "User doesn't exist" }, status: :unauthorized
  end
end
