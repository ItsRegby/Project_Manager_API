RSpec.describe Tasks::InvalidateCacheService do
  let(:project) { create(:project) }

  describe ".call" do
    it "deletes all related cache keys" do
      expect(Rails.cache).to receive(:delete).with("user_#{project.user.id}_projects")
      expect(Rails.cache).to receive(:delete).with("project_#{project.id}_tasks")
      expect(Rails.cache).to receive(:delete).with("project_#{project.id}_stats")

      Task.statuses.keys.each do |status|
        expect(Rails.cache).to receive(:delete).with("project_#{project.id}_tasks_status_#{status}")
      end

      described_class.call(project)
    end
  end
end
