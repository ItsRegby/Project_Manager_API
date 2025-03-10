RSpec.describe Tasks::CreateService do
  let(:project) { create(:project) }
  let(:valid_params) { { name: "New Task", description: "Task description", status: "not_started" } }
  let(:invalid_params) { { name: "", description: "", status: "" } }

  describe ".call" do
    context "with valid params" do
      it "creates a task and invalidates cache" do
        expect(Tasks::InvalidateCacheService).to receive(:call).with(project)

        result = described_class.call(project, valid_params)

        expect(result.success?).to be true
        expect(result.data).to be_a(Task)
        expect(result.data.name).to eq("New Task")
      end
    end

    context "with invalid params" do
      it "returns validation errors" do
        result = described_class.call(project, invalid_params)

        expect(result.success?).to be false
        expect(result.error).to include("Name can't be blank")
      end
    end
  end
end
