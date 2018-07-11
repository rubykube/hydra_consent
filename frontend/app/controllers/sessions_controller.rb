class SessionsController < ApplicationController
  def new
  end

  def callback
    render plain: params
  end
end
