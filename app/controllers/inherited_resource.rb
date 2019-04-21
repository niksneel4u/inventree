# frozen_string_literal: true

# comman methods for crud
class InheritedResource < ApplicationController
  def index
    @q = collection.ransack(params[:q])
    @collection = @q.result.page(params[:page]).per(Settings.pagination.per_page)
    respond_to do |format|
      format.html
      format.js { render 'shared/index' }
    end
  end

  def new
    @resource = resource_class.new
    authorize @resource
  end

  def create
    new
    @resource = resource_class.new(resource_params)
    authorize @resource
    @resource.save!
    respond_with_flash
  rescue StandardError
    flash_for_error
    render 'new'
  end

  def edit
    resource
  end

  def update
    resource.update!(resource_params)
    flash[:notice] = t("#{downcase_class}.updated")
    redirect_to resource_index_path
  rescue StandardError
    flash_for_error
    render 'edit'
  end

  def destroy
    resource.destroy!
    redirect_to resource_index_path
  end

  private

  def downcase_class
    class_name.underscore
  end

  def flash_for_error
    flash[:error] = @resource.errors.full_messages.join(' ,')
  end

  def class_name
    self.class.name.demodulize.sub(/Controller$/, '').singularize
  end

  def resource_class
    @resource_class ||=  begin
      namespaced_class = class_name
      namespaced_class.constantize
                         rescue NameError
                           nil
    end
  end

  def respond_with_flash
    @resource.save!
    flash[:notice] = t("#{downcase_class}.created")
    redirect_to after_create_path
  end

  def resource_index_path
    try("#{controller_name}_path")
  end

  def after_create_path
    resource_index_path
  end

  def collection
    @collection ||= policy_scope(resource_class).all
  end

  def resource
    @resource ||= resource_class.find_by(id: params[:id]).tap do |resource|
      authorize resource
    end
  end

  def required_params
    params.require(downcase_class.to_sym)
  end

  def resource_params
    required_params.permit(permited_params)
  end

  def permited_params
    (@resource.attributes.keys.- %w{id created_at updated_at}).map {|attribute| attribute.to_sym}
  end
end
