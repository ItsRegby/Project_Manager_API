module Auth
  class RegisterService < BaseService
    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      user = User.new(@params)

      return ServiceResult.failure(user.errors.full_messages) unless user.save

      generate_token_response(user)
    end
  end
end
