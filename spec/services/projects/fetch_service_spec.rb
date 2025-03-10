RSpec.describe Projects::FetchService do
  let(:user) { create(:user) }
  let!(:project) { create(:project, user: user) }

  describe ".call" do
    it "returns cached projects" do
      cached_projects = [ project ]
      allow(Rails.cache).to receive(:fetch).with("user_#{user.id}_projects", expires_in: 1.hour).and_return(cached_projects)

      result = described_class.call(user)

      expect(result.success?).to be true
      expect(result.data).to include(project)
    end
  end
end
