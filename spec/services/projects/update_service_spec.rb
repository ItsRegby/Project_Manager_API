RSpec.describe Projects::UpdateService do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user, name: "Old Name") }

  describe ".call" do
    context "with valid params" do
      it "updates the project and clears cache" do
        expect(Rails.cache).to receive(:delete).with("user_#{user.id}_projects")

        result = described_class.call(project, { name: "New Name" })

        expect(result.success?).to be true
        expect(result.data.name).to eq("New Name")
      end
    end

    context "with invalid params" do
      it "returns validation errors" do
        result = described_class.call(project, { name: "" })

        expect(result.success?).to be false
        expect(result.error).to include("Name can't be blank")
      end
    end
  end
end
