class AdminApi::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::UsersController

  # GET /admin_api/v1/users
  def index
    @users = User.includes(:user_role)

    @users = @users.where('LOWER(email) LIKE ?', "%#{params[:email].downcase}%") unless params[:email].blank?
    @users = @users.where("LOWER(CONCAT(first_name, ' ', last_name)) LIKE ?", "%#{params[:name].downcase}%") unless params[:name].blank?

    unless params[:role].blank?
      @users = @users.where(user_role: { role_id: Role.where(role_name: 'USER').first.id }) if params[:role].try(:upcase).eql?('USER')
      @users = @users.where(user_role: { role_id: Role.where(role_name: 'SUPERADMIN').first.id }) if params[:role].try(:upcase).eql?('SUPERADMIN')
    end
  end

  # GET /admin_api/v1/users/1
  def show
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: { user_id: ['Not Found.'] } }, status: :not_found
  end

  # POST /admin_api/v1/users
  def create
    interact = AdminApi::V1::CreateUser.call(data: params, current_user: current_user)
    if interact.success?
      @user = interact.user
    else
      render json: { error: interact.error }, status: 422
    end
  end

  # PATCH/PUT /admin_api/v1/users/1
  def update
    interact = AdminApi::V1::UpdateUser.call(data: params)

    if interact.success?
      render json: { message: 'Success' }
    else
      render json: { error: interact.error }, status: 422
    end
  end

  # DELETE /admin_api/v1/users/1
  def destroy
    @user = User.find(params[:user_id])
    if %w[development staging].any? { |keyword| Rails.env.include?(keyword) }
      if @user.destroy
        render json: { message: 'Success' }
      else
        render json: { message: 'Error deleting user data.' }, status: 422
      end
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: { user_id: ['Not Found.'] } }, status: :not_found
  end
end
