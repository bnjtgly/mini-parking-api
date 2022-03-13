class AdminApi::V1::CreateCustomer
  include Interactor

  delegate :data, to: :context

  def call
    validate!
    build
  end

  def rollback
    context.customer&.destroy
  end

  private

  def build
    @customer = Customer.new(payload)
    Customer.transaction do
      @customer.save
    end

    context.customer = @customer
  end

  def validate!
    verify = AdminApi::V1::CreateCustomerValidator.new(payload)

    return true if verify.submit

    context.fail!(error: verify.errors)
  end

  def payload
    {
      vehicle_type_id: data[:customer][:vehicle_type_id],
      complete_name: data[:customer][:complete_name],
      plate_number: data[:customer][:plate_number]
    }
  end
end
