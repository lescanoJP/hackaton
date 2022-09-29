require 'base64'
require 'json'
require 'httparty'

class BaseClient
  HEADER = { 'Content-Type': 'application/json' }.freeze

  def initialize(base_url)
    @base_url = base_url
  end

  def get(endpoint, query = nil)
    log "\n========== Start post request ==========\n"
    log "Request to ===> #{@base_url}#{endpoint} \n"

    response = handle_response(HTTParty.get("#{@base_url}#{endpoint}",
                                            headers: HEADER,
                                            query: query))

    log "\n======================================== \n"
    response
  end

  def post(endpoint, body = nil, headers = HEADER)
    log "\n========== Start post request ==========\n"
    log "Request to ===> #{@base_url}#{endpoint} \n"

    response = handle_response(HTTParty.post("#{@base_url}#{endpoint}",
                                             headers: headers,
                                             body: body))

    log "\n======================================== \n"
    response
  end

  def put(endpoint, body = nil)
    log "\n========== Start put request ==========\n"
    log "Request to ===> #{@base_url}#{endpoint} \n"

    response = handle_response(HTTParty.put("#{@base_url}#{endpoint}",
                                            headers: HEADER,
                                            body: body))

    log "\n======================================== \n"
    response
  end

  def delete(endpoint)
    log "\n========== Start delete request ========\n= "
    log "Request to ===> #{@base_url}#{endpoint} \n"

    response = handle_response(HTTParty.delete("#{@base_url}#{endpoint}",
                                               headers: HEADER))

    log "\n======================================== \n"
    response
  end

  private

  def handle_response(response)
    log("Response with status code #{response.response.code} #{response.response.message}")
    parsed_response = response.parsed_response
    if response.code.to_i >= 400 && response.code.to_i <= 599
      response = response_object_template(response.code, response.message, parse_response(parsed_response), {})
    else
      response = response_object_template(response.code, response.message, {}, parse_response(parsed_response))
    end
    ::Responder.new(response)
  end

  def parse_response(response)
    parsed_response = response
    return parsed_response if !parsed_response || parsed_response.instance_of?(String)

    if parsed_response.instance_of?(Array)
      parsed_response.map(&:deep_symbolize_keys)
    else
      parsed_response.deep_symbolize_keys
    end
  end

  def log(message)
    Rails.logger.info(message)
  end

  def response_object_template(code, message, error, result)
    { status: code, message: message, error: error, result: result }
  end

end
