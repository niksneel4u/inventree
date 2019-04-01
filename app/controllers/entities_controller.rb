# frozen_string_literal: true

class EntitiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @entity = Entity.new
  end

  def create
    @entity = Entity.new(entity_params)
    if @entity.save!
      flash[:alert] = 'Entity Created.'
      redirect_to entities_path
    else
      render 'new'
    end
  end

  private

  def entity_params
    params.require(:entity).permit(:name)
  end
end
