module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_request, only: [ :login, :register ]

      # POST /api/v1/auth/login
      def login
        result = Auth::LoginService.call(email: params[:email], password: params[:password])

        if result.success?
          render json: result.data
        else
          render json: { error: result.error }, status: :unauthorized
        end
      end

      # POST /api/v1/auth/register
      def register
        result = Auth::RegisterService.call(user_params)

        if result.success?
          render json: result.data, status: :created
        else
          render json: { errors: result.error }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end
