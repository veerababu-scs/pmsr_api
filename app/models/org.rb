class Org < ApplicationRecord
	has_many :users
	validates :org_name, presence: true
end
