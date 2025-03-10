module Projects
  class StatsService
    def self.call(project)
      stats = Rails.cache.fetch("project_#{project.id}_stats", expires_in: 30.minutes) do
        project.tasks_stats
      end

      ServiceResult.success(stats)
    end
  end
end
