module Tasks
  class CreateService
    def self.call(project, params)
      task = project.tasks.build(params)

      return ServiceResult.failure(task.errors.full_messages) unless task.save

      InvalidateCacheService.call(project)
      ServiceResult.success(task)
    end
  end
end
