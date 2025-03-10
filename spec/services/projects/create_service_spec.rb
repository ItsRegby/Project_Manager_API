RSpec.describe Projects::CreateService do
  let(:user) { create(:user) }
  let(:valid_params) { { name: "New Project", description: "Project description" } }
  let(:invalid_params) { { name: "", description: "" } }

  describe ".call" do
    context "with valid params" do
      it "creates a project and clears cache" do
        expect(Rails.cache).to receive(:delete).with("user_#{user.id}_projects")

        result = described_class.call(user, valid_params)

        expect(result.success?).to be true
        expect(result.data).to be_a(Project)
        expect(result.data.name).to eq("New Project")
      end
    end

    context "with invalid params" do
      it "returns validation errors" do
        result = described_class.call(user, invalid_params)

        expect(result.success?).to be false
        expect(result.error).to include("Name can't be blank")
      end
    end
  end
end
