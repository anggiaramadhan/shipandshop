module Registration
  class Create
    attr_accessor :email, :password, :password_confirmation

    def initialize(payload)
      @email = payload[:email]
      @password = payload[:password]
      @password_confirmation = payload[:password_confirmation]
    end

    def call
      return error_persisted if user_persist?
      return error_password_match unless password_match?

      create_user
      success
    end

    private

    def user
      @user ||= User.find_by(email: email)
    end

    def user_persist?
      user.present?
    end

    def error_persisted
      {
        status: :unprocessable_entity,
        message: 'email already exist'
      }
    end

    def password_match?
      password == password_confirmation
    end

    def error_password_match
      {
        status: :not_acceptable,
        message: 'password and password confirmation did not match'
      }
    end

    def create_user
      User.create(email: email, password: password, password_confirmation: password_confirmation)
    end

    def success
      {
        status: :created,
        data: { id: create_user.id.to_s, email: create_user.email },
        message: 'user has been created'
      }
    end

  end
end
