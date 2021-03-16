class TasksController < ApplicationController

	before_action :authenticate!

	def new_task

		@task = Task.new
		@task.name = params[:name]
		@task.title = params[:title]
		@task.status = params[:status]
		@task.task_time = params[:task_time]
		@task.task_date = DateTime.now
		@task.project_id = params[:project_id]

		if @task.project_id.present?
			@project = User.find(current_user.id).projects.find(params[:project_id]) rescue nil

			if !@project.nil?				
				if @task.save
					output = {
					"Message" => "Task Created Succcessfully",
					"Task Name" => @task.name,
					"Task Title" => @task.title,
					"Task Status" => @task.status,
					"Task Time" => "#{@task.task_time} Hours",
					"Task Date" => @task.task_date.strftime("%a %d-%b-%Y"),
					"Project Name" => @task.project.project_name
					}
					render( json: TaskSerializer.render_info(output), status: 200 )
				else
					render( json: TaskSerializer.render_error(@task.errors), status: 422 )
				end
			else
				render( json: TaskSerializer.render_error("Project Not Found"), status: 422 )
			end
		end
	
	end

	def user_tasks

		@projects = User.find(current_user.id).projects.all
        @pc = Array.new()
        @tc = Array.new()
        @tt = 0
        @projects.each do |item|
        	@tasks = Project.find(item.id).tasks
        	@tasks.each do |t|
        		tasks = {
        			"Task Name"=>t.name.titleize,
        			"Task Title"=>t.title.titleize,
        			"Status"=>t.status.titleize,
        			"Task Time"=>"#{t.task_time} Hours",
        			"Task Created on"=>t.task_date.strftime("%a %d-%b-%Y"),
        			"Project Name"=>t.project.project_name.titleize
        		}
        	@tc.push(tasks)
        	end	
        @tt = @tt + @tasks.count
        end
        output = {
            "Total No of Tasks" => @tt,
            "Tasks List" => @tc
        }
        render( json: TaskSerializer.render_info(output), status: 200 )
	
	end

	def task_details

		@task = Task.find(params[:id]) rescue nil
		if !@task.nil?	
			if @task.project.user.id == current_user.id
				task = {
				"Task Name" => @task.name.titleize,
				"Task Title"=> @task.title.titleize,
				"Task Status"=> @task.status.titleize,
				"Task Time" => "#{@task.task_time} Hours",
				"Task Created on" => @task.task_date.strftime("%a %d-%b-%Y"),
				"Project Name"=> @task.project.project_name.titleize,
				}
				output = {
					"Task Details" => task
				}
				render( json: TaskSerializer.render_info(output), status: 200 )
			else
				render( json: TaskSerializer.render_error("User Does Not Have any Task"), status: 422 )
			end	
        else
        	render( json: TaskSerializer.render_error("Task Not Found"), status: 422 )
        end

	end

	def edit_task

		@task = Task.find(params[:id]) rescue nil
		if !@task.nil?			
		 	if @task.project.user.id == current_user.id				
				@task.name = params[:name]
				@task.title = params[:title]
				@task.status = params[:status]
				@task.task_time = params[:task_time]
				@task.task_date = DateTime.now				
		 		if @task.save!					
					task = {
						"Task Name" => @task.name.titleize,
						"Task Title"=> @task.title.titleize,
						"Task Status"=> @task.status.titleize,
						"Task Time" => "#{@task.task_time} Hours",
						"Task Created on" => @task.task_date.strftime("%a %d-%b-%Y")
					}
					output = {
						"Message" => "Task Updated Succcessfully",
						"Task Details" => task
					}
					render( json: TaskSerializer.render_info(output), status: 200 )
				end
		 	else
 				render( json: TaskSerializer.render_error("Invalid Task"), status: 422 )
		 	end
	    else
	       	render( json: TaskSerializer.render_error("Task Not Found"), status: 422 )
	    end

	end

	def delete_task

		@task = Task.find(params[:id]) rescue nil		
		if !@task.nil?			
			if @task.project.user.id == current_user.id
				@task.destroy
				if @task.destroy
				output = {
				"Message" => "Task Deleted Succcessfully"
				}
				end
				render( json: TaskSerializer.render_info(output), status: 200 )	
			else
				render( json: TaskSerializer.render_error("Task Not Found"), status: 422 )
			end
		else
			render( json: TaskSerializer.render_error("Task Not Found"), status: 422 )
		end
		
	end

end
