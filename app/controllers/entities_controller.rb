# frozen_string_literal: true

class EntitiesController < InheritedResource

  private

  def resource_params
    required_params.permit(:name)
  end
end
