class UserSerializer < ActiveModel::Serializer
  #attributes User.column_names
  def self.render_info(data)
  	data
  end
  def self.render_error(errors)
  	{errors: errors}
  end
end
