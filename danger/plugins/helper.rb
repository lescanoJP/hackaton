require_relative '../../lib/git/danger/helper'
# # Common helper functions for our danger scripts. See Gitlab::Danger::Helper
# # for more details
return if Rails.env.staging? || Rails.env.production?

module Danger
  class Helper < Plugin
    # Put the helper code somewhere it can be tested
    include Git::Danger::Helper

  end
end
