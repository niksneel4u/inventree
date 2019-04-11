# frozen_string_literal: true

class EntitiesController < InheritedResource
  before_action :authenticate_user!
  private

  def resource_params
    params.require(:entity).permit(:name)
  end
end
