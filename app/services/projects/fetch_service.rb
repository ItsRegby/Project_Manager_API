module Projects
  class FetchService
    def self.call(user)
      projects = Rails.cache.fetch("user_#{user.id}_projects", expires_in: 1.hour) do
        user.projects.includes(:tasks).to_a
      end

      ServiceResult.success(projects)
    end
  end
end
