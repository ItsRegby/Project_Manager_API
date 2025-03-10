RSpec.describe Task, type: :model do
  it { should belong_to(:project) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status) }

  it { should define_enum_for(:status).with_values(not_started: 0, in_progress: 1, completed: 2) }

  describe "when created with valid attributes" do
    let(:task) { build(:task) }

    it "is valid" do
      expect(task).to be_valid
    end
  end

  describe ".by_status" do
    before do
      @project = create(:project)
      create(:task, project: @project, status: 'not_started')
      create(:task, project: @project, status: 'in_progress')
      create(:task, project: @project, status: 'in_progress')
      create(:task, project: @project, status: 'completed')
    end

    it "filters tasks by the given status" do
      expect(Task.by_status('not_started').count).to eq(1)
      expect(Task.by_status('in_progress').count).to eq(2)
      expect(Task.by_status('completed').count).to eq(1)
    end

    it "returns all tasks when status is not provided" do
      expect(Task.by_status(nil).count).to eq(4)
    end
  end
end
