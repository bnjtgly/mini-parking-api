class AdminApi::V1::CreateEntryPoint
  include Interactor

  delegate :data, to: :context

  def call
    build
  end

  def rollback
    context.entry_points&.destroy
  end

  private

  def build
    context.fail!(error: { entry_points: ['A minimum of 3 entry points is required.'] }) if payload[:name].size < 3

    payload[:name].each do |entry_point|
      @entry_points = EntryPoint.new({ parking_complex_id: context.parking_complex.id, name: entry_point })

      EntryPoint.transaction do
        @entry_points.save
      end
    end

    context.entry_points = @entry_points
  end

  def payload
    {
      name: data[:parking_complex][:entry_points][:name]
    }
  end
end
