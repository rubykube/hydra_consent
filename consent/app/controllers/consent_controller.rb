class ConsentController < ApplicationController
  before_action :set_challenge_code

  def new
    response = hydra.getConsentRequest(@challenge_code)
    logger.debug { response }

    if response[:skip]
      response = hydra.acceptConsentRequest(@challenge_code, grant_scope: response[:requested_scope]
      logger.debug { response }
      return redirect_to response[:redirect_to] if response[:redirect_to]
    end

    @requested_scope = response[:requested_scope]
    @subject = response[:subject]
    @client = response[:client]
  end

  def create
    # TODO: Implement with https://github.com/ory/hydra-login-consent-node/blob/master/routes/consent.js
    render :new
  end

  private

  def set_challenge_code
    @challenge_code = params[:consent_challenge]
  end

  def hydra
    HydraService.new
  end
end
