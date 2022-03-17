class AdminApi::V1::CreateParking
  include Interactor

  delegate :data, to: :context

  def call
    init
    validate!
    build
  end

  def rollback; end

  private

  def init
    @customer_parking = CustomerParking.where(customer_id: data[:parking][:customer_id]).order(created_at: :desc).load_async.first
    @ps_parked = SubEntity.where(value_str: 'parked').load_async.first

    context.fail!(error: { message: ['Please try again. Un-park your vehicle first.'] }) if @customer_parking && @customer_parking.valid_thru.nil?
  end

  def build
    @not_available = SubEntity.includes(:entity).where(value_str: 'not available', entity: {entity_number: 1201}).first
    @parking_slot = ParkingSlot.where(id: payload[:parking_slot_id]).last

    ap @parking_slot

    if @customer_parking && is_returning_vehicle
      @customer_parking_new = CustomerParking.new(customer_id: @customer_parking.customer_id,
                                              is_returnee: true,
                                              current_flat_rate: @customer_parking.current_flat_rate,
                                              parking_slot_id: payload[:parking_slot_id],
                                              parking_status_id: @ps_parked.id,
                                              valid_from: @customer_parking.valid_from)
    else
      @customer_parking_new = CustomerParking.new(payload)
    end

    CustomerParking.transaction do
      @customer_parking_new.valid_from = payload[:valid_from] ? Time.zone.parse(payload[:valid_from]).utc : Time.now.utc
      @customer_parking_new.save
    end
    @parking_slot&.update(parking_slot_status_id: @not_available.id)

    context.customer_parking = @customer_parking_new
  end

  def validate!
    verify = AdminApi::V1::CreateParkingValidator.new(payload)

    return true if verify.submit

    context.fail!(error: verify.errors)
  end

  def payload
    {
      customer_id: data[:parking][:customer_id],
      parking_slot_id: data[:parking][:parking_slot_id],
      parking_status_id: @ps_parked.id,
      valid_from: data[:parking][:valid_from],
      valid_thru: data[:parking][:valid_thru]
    }
  end

  def is_returning_vehicle
    ap "Time away: #{Time.zone.now - @customer_parking.valid_thru}"
    park_in_time = payload[:valid_from] ? Time.zone.parse(payload[:valid_from]).utc : Time.now.utc
    (park_in_time - @customer_parking.valid_thru) / 1.hour <= 1
  end
end
