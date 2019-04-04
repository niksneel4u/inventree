# frozen_string_literal: true

class EntitiesController < InheritedResource
  before_action :authenticate_user!
  def create
    @entity = Entity.new(entity_params)
    if @entity.save!
      flash[:notice] = 'Entity Created.'
      redirect_to entities_path
    else
      render 'new'
    end
  end

  def edit
    @entity = Entity.find(params[:id])
  end

  def update
    @entity = Entity.find(params[:id])
    if @entity.update(entity_params)
      redirect_to entities_path
    else
      render 'edit'
    end
  end

  def new
    @entity = Entity.new
  end

  def destroy
    @entity = Entity.find(params[:id])
    @entity.destroy
    redirect_to entities_path
  end

  private

  def entity_params
    params.require(:entity).permit(:name)
  end

  def entities
    @entities ||= Entity.all
  end
end
