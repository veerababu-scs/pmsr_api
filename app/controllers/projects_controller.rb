class ProjectsController < ApplicationController
	
	before_action :authenticate!

	def new_project

		@project = Project.new

		@project.project_name = params[:project_name]
		@project.project_type = params[:project_type]
		@project.user_id = current_user.id

		if @project.save
			output = {
			"Message" => "Project Created Succcessfully",
			"Project Name" => @project.project_name,
			"Project Type" => @project.project_type
			}
			render( json: ProjectSerializer.render_info(output), status: 200 )
		else
			render( json: ProjectSerializer.render_error(@project.errors).to_json, status: 422 )
		end
	end

	def user_projects

		@projects = User.find(current_user.id).projects.all
        @pc = Array.new()

        @projects.each do |item|

            projects = {
                "Project Name"=>item.project_name,
                "Project Type"=>item.project_type
            }

         @pc.push(projects)
        end

        output = {
            "Project Count" => @projects.count,
            "Projects List" => @pc
        }
        
        render( json: ProjectSerializer.render_info(output), status: 200 )
	end

end
