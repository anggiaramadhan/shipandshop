class SessionsController < ApplicationController
  def create
    session = Session::Create.new(session_params).call
    render json: session
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
