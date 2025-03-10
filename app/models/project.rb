class Project < ApplicationRecord
  belongs_to :user

  has_many :tasks, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id, message: "Project name must be unique per user" },
            length: { maximum: 100 }

  validates :description, presence: true, length: { maximum: 1000 }


  def tasks_stats
    tasks.group(:status).count
  end
end
