class AdminApi::V1::EntitiesController < ApplicationController
  # before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::EntitiesController

  # GET /admin_api/v1/entities
  def index
      @entities = Entity.includes(:sub_entities).references(:sub_entities).order('sub_entities.sort_order')
      @entities = @entities.where('LOWER(entity_name) LIKE ?', "%#{params[:entity_name].downcase}%") unless params[:entity_name].blank?
      @entities = @entities.where(entity_number: params[:entity_number]) unless params[:entity_number].blank?
  end
end
