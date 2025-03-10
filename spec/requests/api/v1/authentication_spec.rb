RSpec.describe "Api::V1::Authentication", type: :request do
  let(:register_url) { "/api/v1/auth/register" }
  let(:login_url) { "/api/v1/auth/login" }

  describe "POST /api/v1/auth/register" do
    let(:valid_attributes) { { email: "user@example.com", password: "password123", password_confirmation: "password123" } }
    let(:invalid_attributes) { { email: "user@example.com", password: "pass", password_confirmation: "pass" } }

    context "with valid parameters" do
      it "creates a new user" do
        expect {
          post register_url, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "returns a JWT token" do
        post register_url, params: valid_attributes

        expect(response).to have_http_status(:created)
        expect(json_response).to have_key('token')
        expect(json_response).to have_key('email')
        expect(json_response).to have_key('user_id')
      end
    end

    context "with invalid parameters" do
      it "doesn't create a new user" do
        expect {
          post register_url, params: invalid_attributes
        }.to change(User, :count).by(0)
      end

      it "returns validation errors" do
        post register_url, params: invalid_attributes

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response).to have_key('errors')
      end
    end
  end

  describe "POST /api/v1/auth/login" do
    let!(:user) { create(:user, email: "user@example.com", password: "password123") }

    context "with valid credentials" do
      it "returns a JWT token" do
        post login_url, params: { email: "user@example.com", password: "password123" }

        expect(response).to have_http_status(:ok)
        expect(json_response).to have_key('token')
        expect(json_response['email']).to eq(user.email)
        expect(json_response['user_id']).to eq(user.id)
      end
    end

    context "with invalid credentials" do
      it "returns unauthorized status" do
        post login_url, params: { email: "user@example.com", password: "wrong_password" }

        expect(response).to have_http_status(:unauthorized)
        expect(json_response).to have_key('error')
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
