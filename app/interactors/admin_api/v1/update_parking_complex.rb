class AdminApi::V1::UpdateParkingComplex
  include Interactor

  delegate :data, to: :context

  def call
    init
    build
  end

  private
  
  def init
    @parking_complex = ParkingComplex.where(id: payload[:parking_complex_id]).load_async.first
    @parking_complex_exists = ParkingComplex.where(name: payload[:name]).load_async.first
  end

  def build
    context.fail!(error: { parking_complex_id: ['Not Found.'] }) unless @parking_complex

    if @parking_complex_exists && !@parking_complex.id.eql?(@parking_complex_exists.id)
      context.fail!(error: { name: ['Already exists.'] })
    else
      @parking_complex.update(name: payload[:name])
    end

    context.parking_complex = @parking_complex
  end

  def payload
    {
      parking_complex_id: data[:parking_complex_id],
      name: data[:parking_complex][:name]
    }
  end
end
