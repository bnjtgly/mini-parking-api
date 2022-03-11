class Api::V1::SubEntitiesController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource class: Api::V1::SubEntitiesController

  # GET /api/sub_entities
  def index
    if (!params[:entity_name].blank? || nil?) || !params[:entity_number].blank? || nil?
      @entity = Entity.includes(:sub_entities).references(:sub_entities).order('sub_entities.sort_order')

      @entity = @entity.where(entity_name: params[:entity_name]) unless params[:entity_name].blank?
      @entity = @entity.where(entity_number: params[:entity_number]) unless params[:entity_number].blank?
      @entity = @entity.first

      return if @entity
    end
    render json: {}
  end
end
