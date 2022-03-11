# frozen_string_literal: true

class Api::V1::InvoicesController < ApplicationController
  # before_action :authenticate_user!
  # authorize_resource class: Api::V1::InvoicesController

  # GET /api/v1/invoices
  def index
    @invoices = Invoice.all
  end
end
