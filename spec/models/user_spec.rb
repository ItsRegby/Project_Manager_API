RSpec.describe User, type: :model do
  it { should have_many(:projects).dependent(:destroy) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should validate_presence_of(:password) }

  describe "when created with valid attributes" do
    let(:user) { build(:user) }

    it "is valid" do
      expect(user).to be_valid
    end
  end
end
