RSpec.describe Projects::DestroyService do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  describe ".call" do
    it "destroys the project and clears cache" do
      expect(Rails.cache).to receive(:delete).with("user_#{user.id}_projects")

      described_class.call(project)

      expect(Project.exists?(project.id)).to be false
    end
  end
end
