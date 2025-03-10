module Tasks
  class InvalidateCacheService
    def self.call(project)
      Rails.cache.delete("user_#{project.user.id}_projects")
      Rails.cache.delete("project_#{project.id}_tasks")
      Rails.cache.delete("project_#{project.id}_stats")

      Task.statuses.keys.each do |status|
        Rails.cache.delete("project_#{project.id}_tasks_status_#{status}")
      end
    end
  end
end
