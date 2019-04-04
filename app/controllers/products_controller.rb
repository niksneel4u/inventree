# frozen_string_literal: true

class ProductsController < InheritedResource
  before_action :authenticate_user!

  def create
    addressable_url = Addressable::URI.parse(params[:product][:product_url])
    url = addressable_url.scheme + '://' + addressable_url.host

    marketplace = Marketplace.find_by(website_url: url)
    if marketplace.blank?
      flash[:notice] = 'URL is not in marketplace list'
      render 'new' and return
    else
      @product = resource_class.new(product_url: params[:product][:product_url], marketplace_id: marketplace.id)
      @product.save!
      redirect_to products_path
    end
  end

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

  def destroy
    @product = resource_class.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  def show
    @product = resource_class.find(params[:id])
    @product_entities = @product.product_entities
  end

  def fetch_latest_data
    @product = resource_class.find(params[:id])
    @product.call_scraping_job
    redirect_to product_path(@product)
  end

  private

  def product_params
    params.require(:product).permit(:product_url, :marketplace_id)
  end

  def resource_class
    current_company.products
  end
end
