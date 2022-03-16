class AdminApi::V1::SlotEntrypointsController < ApplicationController
  # before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::SlotEntrypointsController

  # GET /admin_api/v1/slot_entrypoints
  def index
    @slot_entrypoints = SlotEntrypoint.all
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


