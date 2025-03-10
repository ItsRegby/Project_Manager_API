RSpec.describe "Api::V1::Tasks", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:token) { JwtService.encode(user_id: user.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  describe "GET /api/v1/projects/:project_id/tasks" do
    before do
      create(:task, project: project, status: 'not_started')
      create(:task, project: project, status: 'in_progress')
      create(:task, project: project, status: 'in_progress')
      create(:task, project: project, status: 'completed')
    end

    it "returns all tasks for the project" do
      get "/api/v1/projects/#{project.id}/tasks", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_response.length).to eq(4)
    end

    it "filters tasks by status" do
      get "/api/v1/projects/#{project.id}/tasks?status=in_progress", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_response.length).to eq(2)
      expect(json_response.all? { |t| t['status'] == 'in_progress' }).to be_truthy
    end
  end

  describe "GET /api/v1/projects/:project_id/tasks/:id" do
    let(:task) { create(:task, project: project) }

    it "returns the requested task" do
      get "/api/v1/projects/#{project.id}/tasks/#{task.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_response['id']).to eq(task.id)
      expect(json_response['name']).to eq(task.name)
    end

    it "returns not found for non-existent task" do
      get "/api/v1/projects/#{project.id}/tasks/99999", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/projects/:project_id/tasks" do
    let(:valid_attributes) { { task: { name: "New Task", description: "Task description", status: "not_started" } } }

    it "creates a new task" do
      expect {
        post "/api/v1/projects/#{project.id}/tasks", params: valid_attributes, headers: headers
      }.to change(Task, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(json_response['name']).to eq("New Task")
      expect(json_response['project_id']).to eq(project.id)
    end
  end

  describe "PUT /api/v1/projects/:project_id/tasks/:id" do
    let(:task) { create(:task, project: project, status: 'not_started') }

    it "updates the task" do
      put "/api/v1/projects/#{project.id}/tasks/#{task.id}",
          params: { task: { status: "in_progress" } },
          headers: headers

      expect(response).to have_http_status(:ok)
      expect(task.reload.status).to eq("in_progress")
    end
  end

  describe "DELETE /api/v1/projects/:project_id/tasks/:id" do
    let!(:task) { create(:task, project: project) }

    it "deletes the task" do
      expect {
        delete "/api/v1/projects/#{project.id}/tasks/#{task.id}", headers: headers
      }.to change(Task, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
