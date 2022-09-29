class Responder
  attr_reader :error, :result

  def initialize(response)
    @response = response
    @result = response[:result]
    @error = response[:error]
  end

  def success?
    status >= 200 && status <= 299
  end

  private

  def status
    @response[:status].to_i
  end

end
