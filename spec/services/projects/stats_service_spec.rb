RSpec.describe Projects::StatsService do
  let(:project) { create(:project) }
  let!(:task1) { create(:task, project: project, status: "not_started") }
  let!(:task2) { create(:task, project: project, status: "in_progress") }

  describe ".call" do
    it "returns cached stats" do
      cached_stats = { "not_started" => 1, "in_progress" => 1 }
      allow(Rails.cache).to receive(:fetch).with("project_#{project.id}_stats", expires_in: 30.minutes).and_return(cached_stats)

      result = described_class.call(project)

      expect(result.success?).to be true
      expect(result.data).to eq({ "not_started" => 1, "in_progress" => 1 })
    end
  end
end
