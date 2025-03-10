module Tasks
  class FetchService
    def self.call(project, status = nil)
      tasks = Rails.cache.fetch("project_#{project.id}_tasks", expires_in: 1.hour) do
        tasks = project.tasks
        tasks = tasks.by_status(status) if status.present?
        tasks.to_a
      end

      ServiceResult.success(tasks)
    end
  end
end
