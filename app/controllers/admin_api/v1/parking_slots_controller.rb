# frozen_string_literal: true

class AdminApi::V1::ParkingSlotsController < ApplicationController
  # before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::ParkingSlotsController

  # GET /api/v1/parking_slots
  def index
    @parking_slots = ParkingSlot.all
    @parking_slots = @parking_slots.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%") unless params[:name].blank?
  end

  # GET /admin_api/v1/parking_slots/1
  def show
    @parking_slot = ParkingSlot.find(params[:parking_slot_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: { parking_slot_id: ['Not Found.'] } }, status: :not_found
  end

  # POST /admin_api/v1/parking_slot
  def create
    interact = AdminApi::V1::CreateParkingSlot.call(data: params)
    if interact.success?
      @parking_slot = interact.parking_slot
    else
      render json: { error: interact.error }, status: 422
    end
  end
end
