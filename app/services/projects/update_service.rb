module Projects
  class UpdateService
    def self.call(project, params)
      return ServiceResult.failure(project.errors.full_messages) unless project.update(params)

      clear_cache(project.user)
      ServiceResult.success(project)
    end

    def self.clear_cache(user)
      Rails.cache.delete("user_#{user.id}_projects")
    end
  end
end
