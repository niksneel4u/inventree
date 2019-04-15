# frozen_string_literal: true

class ProductsController < InheritedResource
  include AuditLog
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
    @product_entities = resource.product_entities
  end

  def fetch_latest_data
    ScrapingJob.perform_now(resource.id)
    redirect_to product_path(resource.id)
  end

  def audits
    @audits_heading = t('audit_title')
    render_audit_logs(audit_logs)
  end

  private

  def audit_logs
    resource.own_and_associated_audits
  end

  def resource_params
    required_params.permit(:product_url, :marketplace_id)
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
      flash[:error] = t('product.valide_marketplace')
      redirect_to new_product_path && return
    else
      required_params[:marketplace_id] = @marketplace.id
    end
  end
end
