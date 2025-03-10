module Tasks
  class DestroyService
    def self.call(task)
      project = task.project
      task.destroy

      InvalidateCacheService.call(project)
    end
  end
end
