class Api::V1::CustomerParkingsController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource class: Api::V1::CustomerParkingsController

  # GET /api/v1/customer_parkings
  def index
    @customer_parkings = CustomerParking.all
  end

  # POST /api/customer_parkings
  def create
    interact = Api::V1::CreateCustomerParking.call(data: params)

    if interact.success?
      @customer_parking = interact.customer_parking
      render json: { message: 'Record created.', data: {customer_parking: @customer_parking} }
    else
      render json: { error: interact.error }, status: 422
    end
  end

  # POST /api/customer_parkings
  def update_parking
    interact = Api::V1::UpdateCustomerParking.call(data: params)

    if interact.success?
      @customer_parking = interact.customer_parking
      render json: { message: 'Record updated.', data: {customer_parking: @customer_parking, invoice: @customer_parking.invoice} }
    else
      render json: { error: interact.error }, status: 422
    end
  end
end
