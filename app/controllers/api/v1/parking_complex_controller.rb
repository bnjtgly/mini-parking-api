# frozen_string_literal: true

class Api::V1::ParkingComplexController < ApplicationController
  # before_action :authenticate_user!
  # authorize_resource class: Api::V1::ParkingComplexController

  # GET /api/v1/parking_complex
  def index
    @parking_complex = ParkingComplex.all
    @parking_complex = @parking_complex.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%") unless params[:name].blank?
  end
end
