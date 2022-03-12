class AdminApi::V1::InvoicesController < ApplicationController
  # before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::InvoicesController

  # GET /admin_api/v1/invoices
  def index
    @invoices = Invoice.all
  end
end
