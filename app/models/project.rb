class Project < ApplicationRecord
	belongs_to :user
	has_many :tasks
	validates :project_name, presence: true
	validates :project_name, uniqueness: { scope: :user_id ,message:"Project Name Already Existed"}
	validates :project_type, presence: {message: "Please Select Project Type"}
end
