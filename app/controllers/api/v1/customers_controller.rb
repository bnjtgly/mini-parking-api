# frozen_string_literal: true

class Api::V1::CustomersController < ApplicationController
  # before_action :authenticate_user!
  # authorize_resource class: Api::V1::CustomersController

  # GET /api/v1/customers
  def index
    @customers = Customer.all
  end
end
