# frozen_string_literal: true

class MarketplacesController < InheritedResource
  def new
    @marketplace = Marketplace.new
  end

  def add_mappings
    Entity.all.each do |entity|
      marketplace.marketplace_mappings.find_or_initialize_by(
        entity_id: entity.id
      )
    end
  end

  def save_mappings
    if marketplace.update(marketplace_params)
      redirect_to marketplaces_path
    else
      render 'add_mappings'
    end
  end

  def create
    @marketplace = Marketplace.new(marketplace_params)
    authorize @marketplace, policy_class: MarketplacePolicy
    if @marketplace.save!
      flash[:alert] = 'Marketplace Created.'
      redirect_to marketplace_add_mappings_path(@marketplace)
    else
      render 'new'
    end
  end

  private

  def marketplace_params
    params.require(:marketplace).permit(
      :name, :website_url,
      marketplace_mappings_attributes: %i[
        id entity_id entity_identifier entity_identifier_value
      ]
    )
  end

  def marketplaces
    @marketplaces ||= Marketplace.all
  end

  def marketplace
    @marketplace ||= marketplaces.find_by(id: params[:id])
  end
end
