class AddOrgToUsers < ActiveRecord::Migration[6.1]
  def change
  	add_reference :users, :org
  	add_foreign_key :users, :orgs
  end
end
