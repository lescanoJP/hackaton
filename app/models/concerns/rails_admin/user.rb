module RailsAdmin::User
  extend ActiveSupport::Concern

  included do
    rails_admin do
      navigation_label I18n.t('admin.navigation_labels.users')

      list do
        field :name
        field :email
        field :document
        field :sign_in_count
        field :last_sign_in_at
        field :last_sign_in_ip
        field :created_at
        field :updated_at
      end

      show do
        field :name
        field :email
        field :document
        field :sign_in_count
        field :last_sign_in_at
        field :last_sign_in_ip
        field :created_at
        field :updated_at
      end

      edit do
        field :name
        field :email
        field :document
        field :password do
          help "#{I18n.t('admin.tooltips.required')} #{I18n.t('admin.tooltips.models.user.password')}"
        end
      end

      create do
        field :name
        field :email
        field :document
        field :password do
          help "#{I18n.t('admin.tooltips.required')} #{I18n.t('admin.tooltips.models.user.password')}"
        end
      end
    end
  end
end
