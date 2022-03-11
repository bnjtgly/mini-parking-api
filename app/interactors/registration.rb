class Registration
  include Interactor

  delegate :data, to: :context

  def call
    validate!
    build
  end

  private

  def build; end

  def validate!
    verify = RegistrationValidator.new(payload)

    return true if verify.submit

    context.fail!(error: verify.errors)
  end

  def payload
    {
      email: data[:user][:email],
      password: data[:user][:password],
      password_confirmation: data[:user][:password_confirmation],
      first_name: data[:user][:first_name],
      last_name: data[:user][:last_name],
      api_client_id: data[:user][:api_client_id]
    }
  end
end
