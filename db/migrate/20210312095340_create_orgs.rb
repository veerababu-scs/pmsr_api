class CreateOrgs < ActiveRecord::Migration[6.1]
  def change
    create_table :orgs do |t|
    	t.string :org_name
      t.timestamps
    end
  end
end
