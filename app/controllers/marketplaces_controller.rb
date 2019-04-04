# frozen_string_literal: true

class MarketplacesController < InheritedResource
  before_action :authenticate_user!

  def new
    @marketplace = Marketplace.new
    authorize @marketplace
  end

  def destroy
    @marketplace = Marketplace.find(params[:id])
    @marketplace.destroy
    redirect_to marketplaces_path
  end

  def edit
    @marketplace = Marketplace.find(params[:id])
  end

  def update
    @marketplace = Marketplace.find(params[:id])
    if @marketplace.update(marketplace_params)
      redirect_to marketplaces_path
    else
      render 'edit'
    end
  end

  def add_mappings
    @marketplace = Marketplace.find(params[:id])
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
    authorize @marketplace
    if @marketplace.save!
      flash[:notice] = 'Marketplace Created.'
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
end
