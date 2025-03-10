module Auth
  class BaseService
    private

    def generate_token_response(user)
      token = JwtService.encode(user_id: user.id)
      ServiceResult.success(token: token, email: user.email, user_id: user.id)
    end
  end
end
