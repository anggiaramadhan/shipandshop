class ApplicationController < ActionController::API

  def token(payload)
    JWT.encode(payload, ENV['SECRET_KEY'])
  end
end
