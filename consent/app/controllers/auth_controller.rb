class AuthController < ApplicationController
  def new
    challenge_code = params[:login_challenge]
    response = HydraService.new.getLoginRequest(challenge_code)

    # TODO: Implement with nodejs consent app
    # https://github.com/ory/hydra-login-consent-node/blob/master/routes/login.js
  end

  def create
    # TODO: Implement with nodejs consent app
    # https://github.com/ory/hydra-login-consent-node/blob/master/routes/login.js
  end
end
