class SessionsController < ApplicationController
  def new
  end

  def callback
    p params
    render plain: 'success callback'
  end
end
