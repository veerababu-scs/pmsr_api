class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
    	t.attachment :avatar
      t.timestamps
    end
  end
end
