# frozen_string_literal: true

# Marketplaces Controller (flipkart, amazon) 
class MarketplacesController < InheritedResource

  before_action :authenticate_user!

  def add_mappings
    @marketplace = Marketplace.find(params[:id])
    Entity.all.each do |entity|
      marketplace.marketplace_mappings.find_or_initialize_by(
        entity_id: entity.id
      )
    end
  end

  def save_mappings
    if marketplace.update(resource_params)
      redirect_to marketplaces_path
    else
      render 'add_mappings'
    end
  end

  private

  def resource_params
    params.require(:marketplace).permit(
      :name, :website_url,
      marketplace_mappings_attributes: %i[
        id entity_id entity_identifier entity_identifier_value block_present
      ]
    )
  end

  def marketplaces
    @marketplaces ||= Marketplace.all
  end

  def marketplace
    @marketplace ||= marketplaces.find_by(id: params[:id])
  end

  def after_create_path
    marketplace_add_mappings_path(@resource)
  end
end
