# frozen_string_literal: true

class ProductsController < InheritedResource

  before_action :authenticate_user!
  before_action :check_valide_uri, only: :create

  attr_reader :marketplace

  # custom product list controller method
  def myindex
    @entitiesarray = []
    @product = Product.all
    @product.each do |product|
      productwise_array = {}
      product.product_entities.each do |e|
        productwise_array[e.entity.name] = e.value
      end
      @entitiesarray << productwise_array
    end
  end

  def show
    @product = resource_class.find(params[:id]).tap do |product|
      authorize product
    end
    @product_entities = @product.product_entities
  end

  def fetch_latest_data
    @product = resource_class.find(params[:id])
    @product.call_scraping_job
    redirect_to product_path(@product)
  end

  private

  def resource_params
    params.require(:product).permit(:product_url, :marketplace_id)
  end

  def resource_class
    policy_scope(current_company&.products)
  end

  def find_marketplace
    addressable_url = Addressable::URI.parse(resource_params[:product_url])
    url = addressable_url.scheme + '://' + addressable_url.host
    @marketplace = Marketplace.find_by(website_url: url)
  end

  def check_valide_uri
    find_marketplace
    if @marketplace.blank?
      flash[:error] = 'URL is not in marketplace list'
      render('new') && return
    else
      params.require(:product)[:marketplace_id] = @marketplace.id
    end
  end
end
