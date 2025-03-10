class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  def render_unauthorized
    render json: { error: "Unauthorized" }, status: :unauthorized
  end

  def extract_token_from_header
    header = request.headers["Authorization"]
    header.split(" ").last if header
  end

  def authenticate_request
    token = extract_token_from_header

    begin
      decoded = JwtService.decode(token)
      if decoded
        @current_user = User.find(decoded[:user_id])
      else
        render_unauthorized
      end
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      render_unauthorized
    end
  end
end
