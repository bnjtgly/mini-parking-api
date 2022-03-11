class AdminApi::V1::UpdateUser
  include Interactor

  delegate :data, to: :context

  def call
    validate!
    build
  end

  def rollback; end

  private

  def build
    @user = User.where(id: payload[:user_id]).first

    # @user&.update(
    #   email: payload[:email],
    #   first_name: payload[:first_name],
    #   last_name: payload[:last_name]
    # )
  end

  def validate!
    verify = AdminApi::V1::UpdateUserValidator.new(payload)

    return true if verify.submit

    context.fail!(error: verify.errors)
  end

  def payload
    {
      user_id: data[:user_id],
      email: data[:user][:email],
      first_name: data[:user][:first_name],
      last_name: data[:user][:last_name]
    }
  end
end
