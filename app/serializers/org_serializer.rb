class OrgSerializer < ActiveModel::Serializer
  #attributes :id, :org_name
  def self.render_info(data)
  	data
  end
  def self.render_error(errors)
  	{errors: errors}
  end
end
