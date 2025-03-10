module Tasks
  class UpdateService
    def self.call(task, params)
      return ServiceResult.failure(task.errors.full_messages) unless task.update(params)

      InvalidateCacheService.call(task.project)
      ServiceResult.success(task)
    end
  end
end
