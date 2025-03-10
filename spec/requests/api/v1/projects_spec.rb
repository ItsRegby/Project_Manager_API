RSpec.describe "Api::V1::Projects", type: :request do
  let(:user) { create(:user) }
  let(:token) { JwtService.encode(user_id: user.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  describe "GET /api/v1/projects" do
    before do
      create_list(:project, 3, user: user)
      other_user = create(:user)
      create_list(:project, 2, user: other_user)
    end

    it "returns only the user's projects" do
      get "/api/v1/projects", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_response.length).to eq(3)
    end

    it "includes brief task info" do
      project = create(:project, user: user)
      create_list(:task, 2, project: project)

      get "/api/v1/projects", headers: headers

      project_response = json_response.find { |p| p['id'] == project.id }
      expect(project_response).to have_key('tasks')
      expect(project_response['tasks'].length).to eq(2)
    end

    it "requires authentication" do
      get "/api/v1/projects"

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /api/v1/projects/:id" do
    let(:project) { create(:project, user: user) }

    before do
      create_list(:task, 3, project: project)
    end

    it "returns the requested project with all tasks" do
      get "/api/v1/projects/#{project.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_response['id']).to eq(project.id)
      expect(json_response['name']).to eq(project.name)
      expect(json_response['tasks'].length).to eq(3)
    end

    it "returns not found for other user's project" do
      other_user = create(:user)
      other_project = create(:project, user: other_user)

      get "/api/v1/projects/#{other_project.id}", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/projects" do
    let(:valid_attributes) { { project: { name: "New Project", description: "Project description" } } }

    it "creates a new project" do
      expect {
        post "/api/v1/projects", params: valid_attributes, headers: headers
      }.to change(Project, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(json_response['name']).to eq("New Project")
      expect(json_response['user_id']).to eq(user.id)
    end

    it "returns validation errors for invalid attributes" do
      post "/api/v1/projects", params: { project: { name: "", description: "Missing name" } }, headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response).to have_key('errors')
    end
  end

  describe "PUT /api/v1/projects/:id" do
    let(:project) { create(:project, user: user) }

    it "updates the project" do
      put "/api/v1/projects/#{project.id}",
          params: { project: { name: "Updated Name" } },
          headers: headers

      expect(response).to have_http_status(:ok)
      expect(project.reload.name).to eq("Updated Name")
    end
  end

  describe "DELETE /api/v1/projects/:id" do
    let!(:project) { create(:project, user: user) }

    it "deletes the project" do
      expect {
        delete "/api/v1/projects/#{project.id}", headers: headers
      }.to change(Project, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end

  describe "GET /api/v1/projects/:id/stats" do
    let(:project) { create(:project, user: user) }

    before do
      create_list(:task, 2, project: project, status: 'not_started')
      create_list(:task, 3, project: project, status: 'in_progress')
      create_list(:task, 1, project: project, status: 'completed')
    end

    it "returns the project stats" do
      get "/api/v1/projects/#{project.id}/stats", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_response['stats']["not_started"]).to eq(2)
      expect(json_response['stats']["in_progress"]).to eq(3)
      expect(json_response['stats']["completed"]).to eq(1)
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
