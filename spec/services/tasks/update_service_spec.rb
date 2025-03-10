RSpec.describe Tasks::UpdateService do
  let(:project) { create(:project) }
  let(:task) { create(:task, project: project, name: "Old Name") }

  describe ".call" do
    context "with valid params" do
      it "updates the task and invalidates cache" do
        expect(Tasks::InvalidateCacheService).to receive(:call).with(project)

        result = described_class.call(task, { name: "New Name" })

        expect(result.success?).to be true
        expect(result.data.name).to eq("New Name")
      end
    end

    context "with invalid params" do
      it "returns validation errors" do
        result = described_class.call(task, { name: "" })

        expect(result.success?).to be false
        expect(result.error).to include("Name can't be blank")
      end
    end
  end
end
