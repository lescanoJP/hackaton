class User < ApplicationRecord
  include TokenAuthenticatable
  include RailsAdmin::User

  # mount_uploader :avatar, AvatarUploader

  validates_presence_of :email, :name
  validates_uniqueness_of :email, case_sensitive: true
  # validate :document_validation, if: -> { document.present? }

  # has_many :devices, as: :pushable, class_name: 'JeraPush::Device'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def document_validation
    return unless document.to_s.length == 11 && CPF.valid?(document)

    errors.add(:document)
  end

end
