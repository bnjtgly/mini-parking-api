# frozen_string_literal: true

class AdminApi::V1::EntryPointsController < ApplicationController
  # before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::EntryPointsController

  # GET /admin_api/v1/parking_slots
  def index
    @entry_points = EntryPoint.includes(:parking_complex)
    @entry_points = @entry_points.where(parking_complex: { id: params[:parking_complex_id] }) unless params[:parking_complex_id].blank?
    @entry_points = @entry_points.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%") unless params[:name].blank?
  end
end