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
			render( json: ProjectSerializer.render_error(@project.errors), status: 422 )
		end
	end

	def user_projects

		@projects = User.find(current_user.id).projects.all
        @pc = Array.new()

        @projects.each do |item|

            projects = {
                "Project Name"=>item.project_name.titleize,
                "Project Type"=>item.project_type.titleize
            }

         @pc.push(projects)
        end

        output = {
            "Projects Count" => @projects.count,
            "Projects List" => @pc
        }
        
        render( json: ProjectSerializer.render_info(output), status: 200 )
	end

	def project_details

		@project = User.find(current_user.id).projects.find(params[:id]) rescue nil
		
		if !@project.nil?
        	project = {
                "Project Name" => @project.project_name.titleize,
                "Project Type"=> @project.project_type.titleize
            }
         output = {
         	"Project Details" => project
         }
        render( json: ProjectSerializer.render_info(output), status: 200 )
        else
        render( json: ProjectSerializer.render_error("Project Not Found"), status: 422 )
        end
        
	end

	def edit_project

		@project = User.find(current_user.id).projects.find(params[:id]) rescue nil

		if !@project.nil?

			@project.project_name = params[:project_name]
			@project.project_type = params[:project_type]

			if @project.save
				output = {
				"Message" => "Project Updated Succcessfully",
				"Project Name" => @project.project_name,
				"Project Type" => @project.project_type
				}
				render( json: ProjectSerializer.render_info(output), status: 200 )
			end

        else
        	render( json: ProjectSerializer.render_error("Project Not Found"), status: 422 )
        end

	end

	def delete_project

		@project = User.find(current_user.id).projects.find(params[:id]) rescue nil

		if !@project.nil?
			@project.destroy
			if @project.destroy
				output = {
				"Message" => "Project Deleted Succcessfully"
				}
			end
			render( json: ProjectSerializer.render_info(output), status: 200 )
        else
        	render( json: ProjectSerializer.render_error("Project Not Found"), status: 422 )
        end
	end

end
