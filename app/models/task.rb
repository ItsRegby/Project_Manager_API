class Task < ApplicationRecord
  belongs_to :project

  enum :status, { not_started: 0, in_progress: 1, completed: 2 }

  validates :name, presence: true, uniqueness: { scope: :project_id, message: "Task name must be unique per project" },
            length: { maximum: 100 }

  validates :description, presence: true, length: { maximum: 1000 }
  validates :status, presence: true

  scope :by_status, ->(status) { where(status: status) if status.present? }
end
