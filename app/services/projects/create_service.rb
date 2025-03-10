module Projects
  class CreateService
    def self.call(user, params)
      project = user.projects.build(params)

      return ServiceResult.failure(project.errors.full_messages) unless project.save

      clear_cache(user)
      ServiceResult.success(project)
    end

    def self.clear_cache(user)
      Rails.cache.delete("user_#{user.id}_projects")
    end
  end
end
