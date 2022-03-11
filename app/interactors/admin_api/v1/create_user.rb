class AdminApi::V1::CreateUser
  include Interactor

  delegate :data, :current_user, to: :context

  def call
    validate!
    build
  end

  def rollback
    context.user&.destroy
  end

  private

  def build
    @user = User.new(payload.except(:role))
    role = Role.where(role_name: payload[:role]).first

    User.transaction do
      @user.api_client_id = current_user.api_client_id
      @user.save
      @user.create_user_role(role_id: role.id)
    end

    context.user = @user
  end

  def validate!
    verify = AdminApi::V1::CreateUserValidator.new(payload)

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
      role: data[:user][:role]
    }
  end
end
