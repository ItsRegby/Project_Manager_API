RSpec.describe JwtService do
  let(:payload) { { user_id: 1 } }
  let(:token) { described_class.encode(payload) }

  describe '.encode' do
    it 'encodes the payload into a JWT token' do
      expect(token).to be_a(String)
      expect(token.split('.').length).to eq(3)
    end

    it 'includes an expiration time in the payload' do
      decoded_payload = JWT.decode(token, described_class::SECRET_KEY)[0]
      expect(decoded_payload).to include('exp')
    end
  end

  describe '.decode' do
    it 'decodes a valid token into the original payload' do
      decoded_payload = described_class.decode(token)
      expect(decoded_payload[:user_id]).to eq(payload[:user_id])
    end

    it 'returns nil for an invalid token' do
      expect(described_class.decode('invalid.token')).to be_nil
    end

    it 'returns nil for an expired token' do
      expired_token = described_class.encode(payload, 1.second.ago)
      expect(described_class.decode(expired_token)).to be_nil
    end
  end
end
