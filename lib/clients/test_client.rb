require 'rack/test'

class TestClient
  include Rack::Test::Methods

  def login(endpoint, body = {})
    response = make_post(endpoint, body)
    auth_headers(response)
    response
  end

  def create_user(endpoint, body = {})
    response = make_post(endpoint, body)
    set_auth_headers(response)
    response
  end

  def make_get(endpoint, query = {})
    handle_response(get(endpoint, query, headers))
  end

  def make_post(endpoint, body = {})
    handle_response(post(endpoint, body, headers))
  end

  def make_put(endpoint, body = nil)
    handle_response(put(endpoint, body, headers))
  end

  def make_delete(endpoint)
    handle_response(delete(endpoint, {}, headers))
  end

  def app
    Rails.application
  end

  def headers
    {
      'HTTP_USER_TOKEN' => @token,
      'HTTP_USER_EMAIL' => @email
    }
  end

  private

  def handle_response(response)
    log("Response with status code #{response.status}")
    if response.body.present?
      json_response = JSON.parse response.body
      json_response.deep_symbolize_keys
    else
      {}
    end
  end

  def log(message)
    Rails.logger.info(message)
  end

  def auth_headers(response)
    @token = response[:token]
    @email = response[:email]
  end

end
