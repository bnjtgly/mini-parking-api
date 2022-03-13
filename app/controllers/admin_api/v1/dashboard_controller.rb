class AdminApi::V1::DashboardController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::DashboardController

  # GET /admin_api/v1/dashboard
  def index
    @parking_complex = ParkingComplex.all.load_async
    @entry_points = EntryPoint.all.load_async
    @parking_slots = ParkingSlot.all.load_async
    @customer_parkings = CustomerParking.all.load_async
    @invoices = Invoice.all.load_async
    @transaction_status = SubEntity.where(value_str: 'settled').load_async.first
    @parking_slot_status = Entity.where(entity_number: 1201).load_async.first

    # Parking slots details
    @parking_slot_available = @parking_slot_status.sub_entities.where(value_str: 'available').first
    @parking_slot_not_available = @parking_slot_status.sub_entities.where(value_str: 'not available').first
    @occupied_slots = @parking_slots.where(parking_slot_status_id: @parking_slot_not_available.id).count
    @available_slots = @parking_slots.where(parking_slot_status_id: @parking_slot_available.id).count

    # Invoices details
    @total_earnings = @invoices.sum(:parking_fee)
    @today_earnings = @invoices.where(transaction_status_id: @transaction_status.id).sum(:parking_fee)
  end

  def latest_parkings
    @customer_parkings = CustomerParking.all
  end
end
