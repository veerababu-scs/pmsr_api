class User < ApplicationRecord
	
	include RailsJwtAuth::Authenticatable
	include RailsJwtAuth::Confirmable
	include RailsJwtAuth::Recoverable
	include RailsJwtAuth::Trackable
	include RailsJwtAuth::Invitable
	include RailsJwtAuth::Lockable
	belongs_to :org
	has_many :projects
	validates :name,:email,:gender,:dob,:job_role,:address, presence: true
	validates :mobile, presence: { message: "Mobile Number Should be Given" }
  	validates :mobile, length: { is:10, message:"Mobile Number Should be 10 Digits"}
	validates :email, presence: true,
                    uniqueness: true,
                    format: URI::MailTo::EMAIL_REGEXP
end
