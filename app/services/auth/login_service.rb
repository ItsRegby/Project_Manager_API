module Auth
  class LoginService < BaseService
    def self.call(email:, password:)
      new(email, password).call
    end

    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      user = User.find_by(email: @email)

      return ServiceResult.failure("Invalid email or password") unless user&.valid_password?(@password)

      generate_token_response(user)
    end
  end
end
