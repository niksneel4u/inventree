# frozen_string_literal: true

class EntitiesController < InheritedResource

  def create
    @entity = Entity.new(entity_params)
    if @entity.save!
      flash[:alert] = 'Entity Created.'
      redirect_to entities_path
    else
      render 'new'
    end
  end

  def new
    @entity = Entity.new
  end

  private

  def entity_params
    params.require(:entity).permit(:name)
  end

  def entities
    @entities ||= Entity.all
  end
end
