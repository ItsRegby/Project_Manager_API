module Projects
  class DestroyService
    def self.call(project)
      user = project.user
      project.destroy
      clear_cache(user)
    end

    def self.clear_cache(user)
      Rails.cache.delete("user_#{user.id}_projects")
    end
  end
end
