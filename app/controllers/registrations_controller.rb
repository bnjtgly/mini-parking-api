class RegistrationsController < Devise::RegistrationsController
  include RackSessionFix
  before_action :authorization
  respond_to :json

  def create
    params[:user][:api_client_id] = ApiClient.where(api_key: decoded_auth_token[:api_key]).load_async.first.id
    interact = Registration.call(data: params)

    if interact.success?
      super
      @user = User.where(id: current_user.id).first
    else
      render json: { error: interact.error }, status: 422
    end
  end

  private

  def authorization
    interact = Authorization.call(headers: request.headers)
    interact.result&.name

    render json: { error: { token: interact.error } }, status: :unauthorized unless interact.success?
  end

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    if setup_user
      render json: { message: 'Successfully created account.' }, status: :ok
    else
      render json: { error: { message: 'An error has occurred while setting up user.' } }
    end
  end

  def register_failed
    render json: { error: [user: 'Something went wrong.'] }
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?

    nil
  end

  def setup_user
    role_user = Role.where(role_name: 'USER').first
    @user.create_user_role(role_id: role_user.id)
  end
end
