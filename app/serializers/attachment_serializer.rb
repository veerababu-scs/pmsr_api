class AttachmentSerializer < ActiveModel::Serializer
  #attributes :id
  def self.render_info(data)
  	data
  end
  def self.render_error(errors)
  	{errors: errors}
  end
end
