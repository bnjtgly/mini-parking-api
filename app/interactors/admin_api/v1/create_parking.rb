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
    @customer_parking = CustomerParking.where(customer_id: data[:parking][:customer_id]).order(created_at: :desc).first
    @parking_status = Entity.where(entity_number: 1301).load_async.first
    @ps_parked = @parking_status.sub_entities.where(value_str: 'parked').first
    context.fail!(error: { message: ['Please try again. Un-park your vehicle first.'] }) if @customer_parking && @customer_parking.valid_thru.nil?
  end

  def build
    if @customer_parking && is_returning_vehicle
      @customer_parking = CustomerParking.new(customer_id: @customer_parking.customer_id,
                                              is_returnee: true,
                                              current_flat_rate: @customer_parking.current_flat_rate,
                                              parking_slot_id: @customer_parking.parking_slot_id,
                                              parking_status_id: @ps_parked.id,
                                              valid_from: @customer_parking.valid_from)
    else
      @customer_parking = CustomerParking.new(payload)
    end

    CustomerParking.transaction do
      @customer_parking.valid_from = payload[:valid_from] ? Time.zone.parse(payload[:valid_from]).utc : Time.now.utc
      @customer_parking.save
    end

    context.customer_parking = @customer_parking
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
      parking_status_id: data[:parking][:parking_status_id],
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
