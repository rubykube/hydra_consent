class HydraService
  include HTTParty
  base_uri ENV.fetch('HYDRA_URL')

  def getLoginRequest(challenge)
    get('login', challenge)
  end

  def acceptLoginRequest(challenge, body)
    put('login', 'accept', challenge, body)
  end

  def rejectLoginRequest(challenge)
    put('login', 'reject', challenge, body)
  end

  def getConsentRequest(challenge)
    get('consent', challenge)
  end

  def acceptConsentRequest(challenge, body)
    put('consent', 'accept', challenge, body)
  end

  def rejectConsentRequest(challenge, body)
    put('consent', 'reject', challenge, body)
  end

  private

  def get(flow, challenge)
    Rails.logger.debug { "Flow #{flow.inspect}" }
    Rails.logger.debug { "challenge #{challenge.inspect}" }
    response = self.class.get("/oauth2/auth/requests/#{flow}/#{challenge}")
    parse_body(response.body)
  end

  def put(flow, action, challenge, body)
    Rails.logger.debug { "Flow #{flow.inspect}" }
    Rails.logger.debug { "action #{action.inspect}" }
    Rails.logger.debug { "challenge #{challenge.inspect}" }
    Rails.logger.debug { "body #{body.inspect}" }
    response = self.class.put("/oauth2/auth/requests/#{flow}/#{challenge}/#{action}", body)
    parse_body(response.body)
  end

  def parse_body(body)
    JSON.parse body, symbolize_names: true
  rescue StandardError => e
    { error: e.message }
  end
end
