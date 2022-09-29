class MinimumVersion < ApplicationRecord
  include RailsAdmin::MinimumVersion
  extend Enumerize

  validates_presence_of :platform, :version_number, :build_number

  enumerize :platform, in: [:ios, :android], scope: :shallow

end
