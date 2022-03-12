class AdminApi::V1::CustomerParkingsController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::CustomerParkingsController

  # GET /admin_api/v1/customer_parkings
  def index
    @customer_parkings = CustomerParking.all
  end
end
