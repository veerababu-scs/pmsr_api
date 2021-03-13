class UsersController < ApplicationController
	
	before_action :authenticate!

	def info
		
		user_details = {
		    "Id" => current_user.id,
		    "Name"=>current_user.name,
		    "Gender"=>current_user.gender,
		    "Date of Birth"=>current_user.dob,
		    "Address"=>current_user.address,
		    "Mobile Number"=>current_user.mobile
		}

		account_details = {
		    "Email" => current_user.email,
		    "Job Role"=>current_user.job_role,
		    "Organization Id"=>current_user.org.org_name,
		    "Last Sign in"=>current_user.last_sign_in_at.strftime("%a %d-%b-%Y"),
		    "No of Projects"=>User.count,
		    "No of Tasks"=>current_user.email
		}

		output = {
			"Logged in as"=>current_user.email,
			"Personal Details" => user_details,
			"Account Details" => account_details
		}
        
		render( json: UserSerializer.render_info(output), status: 200 )
	end
end
