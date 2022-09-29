class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :document, :token

  def token
    scope[:token] if scope.present?
  end

end
