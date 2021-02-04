class RegistrationsController < ApplicationController
  def create
    registration = Registration::Create.new(registration_params).call
    render json: registration
  end

  private

  def registration_params
    params.require(:registration)
          .permit(:email, :password, :password_confirmation)
  end
end
