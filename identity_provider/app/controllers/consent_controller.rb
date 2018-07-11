class ConsentController < ApplicationController
  before_action :set_challenge_code

  def new
    response = hydra.getConsentRequest(@challenge_code)
    flash[:alert] = response if response[:error]

    if response[:skip]
      response = hydra.acceptConsentRequest(@challenge_code, grant_scope: response[:requested_scope])
      return redirect_to response[:redirect_to] if response[:redirect_to]
    end

    @scopes = response[:requested_scope]
    @subject = response[:subject]
    @client = response[:client]
  end

  def create
    if params[:deny]
      hydra.rejectConsentRequest(@challenge_code,
        error: 'access_denied',
        error_description: 'The resource owner denied the request')
      return redirect_to response[:redirect_to] if response[:redirect_to]
    end

    hydra_params = { grant_scope: params[:scopes] || [] }
    hydra_params.merge!(remember: true, remember_for: 3600) if params[:remember_me]
    response = hydra.acceptConsentRequest(@challenge_code, hydra_params)
    redirect_to response[:redirect_to] if response[:redirect_to]
  end

  private

  def set_challenge_code
    @challenge_code = params[:consent_challenge]
    not_found unless @challenge_code
  end

  def hydra
    HydraService.new
  end
end
