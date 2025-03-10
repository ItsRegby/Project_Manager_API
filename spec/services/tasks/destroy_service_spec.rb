RSpec.describe Tasks::DestroyService do
  let(:project) { create(:project) }
  let(:task) { create(:task, project: project) }

  describe ".call" do
    it "destroys the task and invalidates cache" do
      expect(Tasks::InvalidateCacheService).to receive(:call).with(project)

      described_class.call(task)

      expect(Task.exists?(task.id)).to be false
    end
  end
end
