RSpec.describe Tasks::FetchService do
  let(:project) { create(:project) }
  let!(:task1) { create(:task, project: project, status: "not_started") }
  let!(:task2) { create(:task, project: project, status: "in_progress") }

  describe ".call" do
    context "without status filter" do
      it "returns all tasks" do
        cached_tasks = [ task1, task2 ]
        allow(Rails.cache).to receive(:fetch).with("project_#{project.id}_tasks", expires_in: 1.hour).and_return(cached_tasks)

        result = described_class.call(project)

        expect(result.success?).to be true
        expect(result.data).to include(task1, task2)
      end
    end

    context "with status filter" do
      it "returns filtered tasks" do
        cached_tasks = [ task1 ]
        allow(Rails.cache).to receive(:fetch).with("project_#{project.id}_tasks", expires_in: 1.hour).and_return(cached_tasks)

        result = described_class.call(project, "not_started")

        expect(result.success?).to be true
        expect(result.data).to include(task1)
        expect(result.data).not_to include(task2)
      end
    end
  end
end
