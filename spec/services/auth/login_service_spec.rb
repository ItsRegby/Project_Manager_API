RSpec.describe Auth::LoginService do
  let(:user) { create(:user, email: "test@example.com", password: "password123") }

  describe ".call" do
    context "with valid credentials" do
      it "returns a token and user info" do
        result = described_class.call(email: user.email, password: "password123")

        expect(result.success?).to be true
        expect(result.data[:token]).to be_present
        expect(result.data[:email]).to eq(user.email)
        expect(result.data[:user_id]).to eq(user.id)
      end
    end

    context "with invalid email" do
      it "returns an error" do
        result = described_class.call(email: "wrong@example.com", password: "password123")

        expect(result.success?).to be false
        expect(result.error).to eq("Invalid email or password")
      end
    end

    context "with invalid password" do
      it "returns an error" do
        result = described_class.call(email: user.email, password: "wrong_password")

        expect(result.success?).to be false
        expect(result.error).to eq("Invalid email or password")
      end
    end
  end
end
