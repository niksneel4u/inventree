# frozen_string_literal: true

class EntitiesController < InheritedResource

  private

  def resource_params
    params.require(:entity).permit(:name)
  end
end
