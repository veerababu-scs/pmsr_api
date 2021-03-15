class AddTasksToUsers < ActiveRecord::Migration[6.1]
  def change
  	add_reference :tasks, :project
  	add_foreign_key :tasks, :projects
  end
end
