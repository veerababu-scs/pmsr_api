class AddProjetToAttachments < ActiveRecord::Migration[6.1]
  def change
  	add_reference :attachments, :project
  	add_foreign_key :attachments, :projects
  end
end
