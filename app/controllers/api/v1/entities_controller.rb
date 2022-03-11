class Api::V1::EntitiesController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource class: Api::V1::EntitiesController

  # GET /api/entities
  def index
    if (!params[:entity_name].blank? || nil?) || !params[:entity_number].blank? || nil?
      @entities = Entity.includes(:sub_entities).references(:sub_entities).order('sub_entities.sort_order')
      @entities = @entities.where('LOWER(entity_name) LIKE ?', "%#{params[:entity_name].downcase}%") unless params[:entity_name].blank?
      @entities = @entities.where(entity_number: params[:entity_number]) unless params[:entity_number].blank?

      return if @entities
    end
    render json: {}
  end
end
