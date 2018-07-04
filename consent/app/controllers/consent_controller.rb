class ConsentController < ApplicationController
  def new
    challenge_code = params[:consent_challenge]
    # TODO: Add hydra service
    response = HydraService.getConsentRequest\(challenge_code)

    # TODO: Implement with nodejs consent app
    # https://github.com/ory/hydra-login-consent-node/blob/master/routes/consent.js
  end

  def create
    # TODO: Implement with nodejs consent app
    # https://github.com/ory/hydra-login-consent-node/blob/master/routes/consent.js
  end
end
