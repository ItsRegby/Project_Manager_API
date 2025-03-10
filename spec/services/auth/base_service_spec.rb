RSpec.describe Auth::BaseService do
  let(:user) { create(:user) }

  describe "#generate_token_response" do
    it "generates a token response" do
      service = described_class.new
      result = service.send(:generate_token_response, user) # Виклик приватного методу

      expect(result.success?).to be true
      expect(result.data[:token]).to be_present
      expect(result.data[:email]).to eq(user.email)
      expect(result.data[:user_id]).to eq(user.id)
    end
  end
end
