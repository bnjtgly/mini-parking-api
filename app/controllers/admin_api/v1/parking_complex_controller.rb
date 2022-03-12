class AdminApi::V1::ParkingComplexController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::ParkingComplexController

  # GET /admin_api/v1/parking_complex
  def index
    @parking_complexes = ParkingComplex.all
    @parking_complexes = @parking_complexes.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%") unless params[:name].blank?
  end

  # GET /admin_api/v1/parking_complex/1
  def show
    @parking_complex = ParkingComplex.find(params[:parking_complex_id])
    # @slot_type_count = @parking_complex.select(:parking_slot_type_ref.display).parking_slots.group(:parking_slot_type_ref.display).count
    @slot_type_count = @parking_complex.parking_slots.select(:id, :parking_slot_type_id).group(:parking_slot_type_id).count(:parking_slot_type_id)
    @slot_type_count = get_slot_type_count

    ap @slot_type_count

  rescue ActiveRecord::RecordNotFound
    render json: { error: { parking_complex_id: ['Not Found.'] } }, status: :not_found
  end

  # POST /admin_api/v1/parking_complex
  def create
    interact = AdminApi::V1::Organizers::SetupParkingComplex.call(data: params, current_user: current_user)
    if interact.success?
      @parking_complex = interact.parking_complex
    else
      render json: { error: interact.error }, status: 422
    end
  end

  # PATCH/PUT /admin_api/v1/parking_complex/1
  def update
    interact = AdminApi::V1::UpdateParkingComplex.call(data: params)

    if interact.success?
      render json: { message: 'Success' }
    else
      render json: { error: interact.error }, status: 422
    end
  end

  # DELETE /admin_api/v1/parking_complex/1
  def destroy
    @parking_complex = ParkingComplex.find(params[:parking_complex_id])
    if %w[development staging].any? { |keyword| Rails.env.include?(keyword) }
      if @parking_complex.destroy
        render json: { message: 'Success' }
      else
        render json: { message: 'Error deleting data.' }, status: 422
      end
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: { parking_complex_id: ['Not Found.'] } }, status: :not_found
  end

  private

  def get_slot_type_count
    slot_type = []
    @slot_type_count.each do |key, val|
      type = SubEntity.where(id: key).first.display
      slot_type << { slot_type: type, count: val }
    end
    slot_type
  end

end
