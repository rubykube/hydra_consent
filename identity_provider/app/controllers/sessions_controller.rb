class SessionsController < ApplicationController
  before_action :set_challenge_code

  def new
    response = hydra.getLoginRequest(@challenge_code)
    logger.debug { response }

    flash[:alert] = response[:error]

    if response[:skip]
      response = hydra.acceptLoginRequest(@challenge_code, subject: response[:subject])
      logger.debug { response }
      flash[:alert] = response[:error]
      return redirect_to response[:redirect_to] if response[:redirect_to]
    end
  end

  def create
    logger.debug { params }

    unless credentials_valid?
      flash[:alert] = 'The username / password combination is not correct'
      return render :new
    end

    response = hydra.acceptLoginRequest(@challenge_code, subject: params[:email],
                                                         remember: params[:remember_me],
                                                         remember_for: 3600)
    logger.debug { response }
    flash[:alert] = response[:error]
    return redirect_to response[:redirect_to] if response[:redirect_to]
    render :new
  end

  private

  def set_challenge_code
    @challenge_code = params[:login_challenge]
    not_found unless @challenge_code
  end

  def hydra
    HydraService.new
  end

  def credentials_valid?
    params[:email] == 'user@example.com' && params[:password] == 'password'
  end
end
