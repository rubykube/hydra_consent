class SessionsController < ApplicationController
  before_action :set_challenge_code

  def new
    response = hydra.getLoginRequest(@challenge_code)
    flash[:alert] = response if response[:error]

    if response[:skip]
      response = hydra.acceptLoginRequest(@challenge_code, subject: response[:subject])
      flash[:alert] = response[:error]
      return redirect_to response[:redirect_to] if response[:redirect_to]
    end
  end

  def create
    unless credentials_valid?
      flash[:alert] = 'The username / password combination is not correct'
      return render :new
    end

    hydra_params = { subject: params[:email] }
    hydra_params.merge!(remember: true, remember_for: 3600) if params[:remember_me]
    response = hydra.acceptLoginRequest(@challenge_code, hydra_params)
    flash[:alert] = response if response[:error]

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
