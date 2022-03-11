class AdminApi::V1::CreateParkingComplex
  include Interactor

  delegate :data, to: :context

  def call
    validate!
    build
  end

  def rollback
    context.parking_complex&.destroy
  end

  private

  def build
    @parking_complex = ParkingComplex.new(payload.except(:entry_points))

    ParkingComplex.transaction do
      @parking_complex.save
    end

    context.parking_complex = @parking_complex
  end

  def validate!
    verify = AdminApi::V1::CreateParkingComplexValidator.new(payload)

    return true if verify.submit

    context.fail!(error: verify.errors)
  end

  def payload
    {
      name: data[:parking_complex][:name]
    }
  end
end
