# frozen_string_literal: true

class Api::V1::ParkingSlotsController < ApplicationController
  # before_action :authenticate_user!
  # authorize_resource class: Api::V1::ParkingSlotsController

  # GET /api/v1/parking_slots
  def index
    @parking_slots = ParkingSlot.all
    @parking_slots = @parking_slots.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%") unless params[:name].blank?
  end
end
