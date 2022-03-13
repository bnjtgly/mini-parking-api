class AdminApi::V1::CreateInvoice
  include Services::CalculationService
  include Interactor

  delegate :data, to: :context

  def call
    init
    # validate!
    build
  end

  def rollback
    context.invoice&.destroy
  end

  private
  def init
    @customer_parking = CustomerParking.where(id: context.customer_parking.id).load_async.first
    @transaction_status = Entity.where(entity_number: 1401).load_async.first
    @ts_pending = @transaction_status.sub_entities.where(value_str: 'pending').first
  end

  def build
    customer_invoice = Invoice.where(customer_id: context.customer_parking.customer_id).first
    context.fail!(error: { customer_parking_id: ['Not found.'] }) unless @customer_parking

    is_flatrate_settled = customer_invoice ? true : false

    @invoice = Invoice.new(payload)
    Invoice.transaction do
      @invoice.is_flatrate_settled = is_flatrate_settled
      @invoice.save
    end

    context.invoice = @invoice
  end

  # def validate!
  #   verify = AdminApi::V1::CreateInvoiceValidator.new(payload)
  #
  #   return true if verify.submit
  #
  #   context.fail!(error: verify.errors)
  # end

  def payload
    {
      customer_parking_id: @customer_parking.id,
      customer_id: @customer_parking.customer_id,
      transaction_status_id: @ts_pending.id
    }
  end
end
