class AdminApi::V1::CustomerParkingsController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::CustomerParkingsController

  # GET /admin_api/v1/customer_parkings
  def index
    @customer_parkings = CustomerParking.all
  end

  # POST /admin_api/v1/customer_parkings
  def create
    # interact = AdminApi::V1::CreateParking.call(data: params)
    interact = AdminApi::V1::Organizers::SetupParking.call(data: params)

    if interact.success?
      @customer_parking = interact.customer_parking.reload
    else
      render json: { error: interact.error }, status: 422
    end
  end

  # POST /admin_api/v1/customer_parkings
  def checkout
    # interact = Api::V1::CreateCheckout.call(data: params)
    interact = AdminApi::V1::Organizers::SetupCheckout.call(data: params)

    if interact.success?
      @customer_parking = interact.customer_parking.reload
      render json: { message: 'Record updated.', data: {customer_parking: @customer_parking, invoice: @customer_parking.invoice} }
    else
      render json: { error: interact.error }, status: 422
    end
  end
end
