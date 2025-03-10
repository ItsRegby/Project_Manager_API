RSpec.describe Project, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:tasks).dependent(:destroy) }

  it { should validate_presence_of(:name) }

  describe "when created with valid attributes" do
    let(:project) { build(:project) }

    it "is valid" do
      expect(project).to be_valid
    end
  end

  describe "#tasks_stats" do
    let(:project) { create(:project) }

    before do
      create_list(:task, 2, project: project, status: 'not_started')
      create_list(:task, 3, project: project, status: 'in_progress')
      create_list(:task, 1, project: project, status: 'completed')
    end

    it "returns the count of tasks grouped by status" do
      stats = project.tasks_stats

      expect(stats["not_started"]).to eq(2)
      expect(stats["in_progress"]).to eq(3)
      expect(stats["completed"]).to eq(1)
    end
  end
end
