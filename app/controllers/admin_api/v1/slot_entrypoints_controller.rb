class AdminApi::V1::SlotEntrypointsController < ApplicationController
  # before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::SlotEntrypointsController

  # GET /admin_api/v1/slot_entrypoints
  def index
    @slot_entrypoints = SlotEntrypoint.includes(:entry_point, parking_slot: :parking_complex)
    @slot_entrypoints = @slot_entrypoints.where(parking_complex: {name: params[:parking_complex]}) unless params[:parking_complex].blank?
  end

  # POST /admin_api/v1/slot_entrypoints
  def create
    interact = AdminApi::V1::CreateSlotEntrypoint.call(data: params)
    if interact.success?
      @slot_entrypoint = interact.slot_entrypoint
    else
      render json: { error: interact.error }, status: 422
    end
  end
end


