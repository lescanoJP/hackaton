class MinimumVersionSerializer < ActiveModel::Serializer
  attributes :platform, :version_number, :build_number, :required, :description

end
