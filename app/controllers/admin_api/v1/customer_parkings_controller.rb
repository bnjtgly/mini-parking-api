class AdminApi::V1::CustomerParkingsController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::CustomerParkingsController

  # GET /admin_api/v1/customer_parkings
  def index
    @customer_parkings = CustomerParking.all
  end

  # GET /admin_api/v1/customer_parkings/find_parking
  def find_parking
    @customer = Customer.where(id: params[:customer_id]).first
    unless params[:entry_point].blank? || params[:parking_complex].blank?
      @available_status = SubEntity.where(value_str: 'available').first
      @customer_vehicle_type = @customer.vehicle_type_ref.sort_order.to_i
      @available_slots = ParkingSlot.joins(slot_entrypoints: :entry_point)
                                    .where(parking_complex_id: params[:parking_complex], entry_point: { name: params[:entry_point] })
                                    .joins('join sub_entities on parking_slots.parking_slot_type_id = sub_entities.id')
                                    .where(sub_entities: { sort_order: @customer_vehicle_type..Float::INFINITY })
                                    .where(parking_slot_status_id: @available_status.id)
                                    .order('slot_entrypoints.distance').first
      @slot_price = @available_slots.parking_slot_type_ref.metadata.to_h if @available_slots
      @slot_price = @slot_price['price'].to_f if @slot_price
      @entry_point_distance = @available_slots.slot_entrypoints.first.distance
    end
    if params[:entry_point].blank? || params[:parking_complex].blank?
      render json: { error: 'Please verify the Parking Complex and Entry point.' }
    else
      render 'admin_api/v1/parking_slots/find_parking'
    end
  end

  # POST /admin_api/v1/customer_parkings
  def create
    interact = AdminApi::V1::Organizers::SetupParking.call(data: params)

    if interact.success?
      @customer_parking = interact.customer_parking
    else
      render json: { error: interact.error }, status: 422
    end
  end

  # POST /admin_api/v1/customer_parkings
  def checkout
    interact = AdminApi::V1::Organizers::SetupCheckout.call(data: params)

    if interact.success?
      @customer_parking_checkout = interact.customer_parking
      # render json: { message: 'Record updated.', data: {customer_parking: @customer_parking, invoice: @customer_parking.invoice} }
    else
      render json: { error: interact.error }, status: 422
    end
  end
end
