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
    response = self.class.get("/oauth2/auth/requests/#{flow}?challenge\=#{challenge}")
    parse_body(response.body)
  end

  def put(flow, action, challenge, body)
    response = self.class.put("/oauth2/auth/requests/#{flow}/#{action}?challenge\=#{challenge}",
                              body: body.to_json,
                              headers: { 'Content-Type' => 'application/json' })
    parse_body(response.body)
  end

  def parse_body(body)
    JSON.parse body, symbolize_names: true
  rescue StandardError => e
    { error: e.message }
  end
end
