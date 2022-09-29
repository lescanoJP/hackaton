class Api::ApiController < ActionController::API
  include ApiTokenAuthenticatable
  include ApiCommonResponses
  include Pagy::Backend

  wrap_parameters false
  respond_to :json

  protected

  def serialize_resource(resource, serializer, scope: nil)
    JSON.parse(serializer.new(resource, scope: scope).to_json)
  end

  def serialize_resource_list(resources, serializer)
    JSON.parse(ActiveModelSerializers::SerializableResource.new(resources, each_serializer: serializer).to_json)
  end

end
