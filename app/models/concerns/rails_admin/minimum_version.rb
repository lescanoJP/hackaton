module RailsAdmin::MinimumVersion
  extend ActiveSupport::Concern

  included do
    rails_admin do
      navigation_label I18n.t('admin.navigation_labels.versions')

      list do
        scopes [nil, :android, :ios]
        field :platform
        field :version_number
        field :build_number
        field :required
        field :description
        field :created_at
        field :updated_at
      end

      show do
        field :platform
        field :version_number
        field :build_number
        field :required
        field :description
        field :created_at
        field :updated_at
      end

      edit do
        field :platform
        field :version_number
        field :build_number
        field :required
        field :description
      end

      create do
        field :platform
        field :version_number
        field :build_number
        field :required
        field :description
      end
    end
  end
end
