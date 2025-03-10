RSpec.describe Auth::RegisterService do
  describe ".call" do
    context "with valid params" do
      let(:valid_params) { { email: "new@example.com", password: "password123", password_confirmation: "password123" } }

      it "creates a new user and returns a token" do
        result = described_class.call(valid_params)

        expect(result.success?).to be true
        expect(result.data[:token]).to be_present
        expect(result.data[:email]).to eq("new@example.com")
        expect(result.data[:user_id]).to be_present
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { email: "", password: "password123", password_confirmation: "password123" } }

      it "returns validation errors" do
        result = described_class.call(invalid_params)

        expect(result.success?).to be false
        expect(result.error).to include("Email can't be blank")
      end
    end

    context "with mismatched password confirmation" do
      let(:invalid_params) { { email: "new@example.com", password: "password123", password_confirmation: "wrong" } }

      it "returns validation errors" do
        result = described_class.call(invalid_params)

        expect(result.success?).to be false
        expect(result.error).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
