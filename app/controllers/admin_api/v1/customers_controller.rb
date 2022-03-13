# frozen_string_literal: true

class AdminApi::V1::CustomersController < ApplicationController
  # before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::CustomersController

  # GET /admin_api/v1/customers
  def index
    @customers = Customer.all

    @customers = @customers.where('LOWER(plate_number) LIKE ?', "%#{params[:plate_number].downcase}%") unless params[:plate_number].blank?
    @customers = @customers.where("LOWER(complete_name) LIKE ?", "%#{params[:name].downcase}%") unless params[:name].blank?
  end

  # GET /admin_api/v1/customers/1
  def show
    @customer = Customer.find(params[:customer_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: { customer_id: ['Not Found.'] } }, status: :not_found
  end

  # POST /admin_api/v1/customers
  def create
    interact = AdminApi::V1::CreateCustomer.call(data: params)
    if interact.success?
      @customer = interact.customer
    else
      render json: { error: interact.error }, status: 422
    end
  end
end

