module Session
  class Create
    include Authenticate

    attr_accessor :email, :password

    def initialize(payload)
      @email = payload[:email]
      @password = payload[:password]
    end

    def call
      if persist?
        return success_response if authenticate?

        error_authenticated
      else
        error_persisted
      end
    end

    private

    def user
      @user ||= User.find_by(email: email)
    end

    def authenticate?
      user.authenticate(password).present?
    end

    def persist?
      user.present?
    end

    def data
      {
        email: user.email,
        token: token({ user_id: user.id.to_s })
      }
    end

    def success_response
      {
        status: :ok,
        data: data,
        message: 'user has been login'
      }
    end

    def error_persisted
      {
        status: :unprocessable_entity,
        message: 'email not been found'
      }
    end

    def error_authenticated
      {
        status: :unauthorized,
        message: 'password is not match'
      }
    end

  end
end