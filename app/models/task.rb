class Task < ApplicationRecord
	belongs_to :project
	validates :name,:title,:status,:task_time,:task_date, presence: true
	validates :title, uniqueness: { scope: :project_id ,message:"Task Title Already Existed"}
end
