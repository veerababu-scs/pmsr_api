class AttachmentsController < ApplicationController
	
	before_action :authenticate!

	def new_image

		@attachment = Attachment.new
		@attachment.project_id = params[:project_id]
		#@attachment.avatar = params[:avatar]

		if @attachment.project_id.present?

			@project = User.find(current_user.id).projects.find(params[:project_id]) rescue nil

			if !@project.nil?
				
				# data = StringIO.new(Base64.decode64(params[:avatar][:data]))
				# puts "...........1"
				# data.class.class_eval { attr_accessor :orginal_filename, :avatar_content_type }
				# puts "...........2"
				# data.orginal_filename = [:avatar][:filename]
				# puts "....#{@attachment.orginal_filename}.......3"
				# data.content_type = params[:avatar][:content_type]
				# puts "...........4"
				# params[:avatar] = data
				if params[:avatar].present?
					puts "present..........."
					image_base = params[:avatar][:base64]
					image = Paperclip.io_adapters.for(image_base)
					image.orginal_filename = [:avatar][:filename]
					@attachment.avatar = image
				end
				#@attachment.avatar = params[:avatar]	
				if @attachment.save
					output = {
					"Message" => "Image Uploaded Succcessfully",
					"Project Name" => @attachment.project.project_name
					#{}"File Name" => @attachment.avatar_file_name
					}
					render( json: AttachmentSerializer.render_info(output), status: 200 )
				else
					render( json: AttachmentSerializer.render_error(@attachment.errors), status: 422 )
				end				
				#render( json: TaskSerializer.render_error("Project Found"), status: 422 )
			else
				render( json: AttachmentSerializer.render_error("Project Not Found"), status: 422 )
			end
		end
	end

end
