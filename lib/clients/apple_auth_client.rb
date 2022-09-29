class ::AppleAuthClient < BaseClient
  URL = 'https://appleid.apple.com/'.freeze

  def initialize
    super(URL)
  end

  def public_key_apple
    get('auth/keys')
  end

end
