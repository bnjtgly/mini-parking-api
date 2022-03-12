class AdminApi::V1::SubEntitiesController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource class: AdminApi::V1::SubEntitiesController

  # GET /admin_api/sub_entities
  def index
      @entity = Entity.includes(:sub_entities).references(:sub_entities).order('sub_entities.sort_order')

      @entity = @entity.where(entity_name: params[:entity_name]) unless params[:entity_name].blank?
      @entity = @entity.where(entity_number: params[:entity_number]) unless params[:entity_number].blank?
      @entity = @entity.first
  end
end
