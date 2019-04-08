# frozen_string_literal: true

# comman methods for crud
class InheritedResource < ApplicationController
  def index
    collection
  end

  def new
    @resource = resource_class.new
    authorize @resource
  end

  def create
    @resource = resource_class.new(resource_params)
    authorize @resource
    @resource.save!
    redirect_to after_create_path
  rescue => e
    flash[:error] = @resource.errors.full_messages.join(' ,')
    render 'new'
  end

  def edit
    resource
  end

  def update
    resource.update!(resource_params)
    redirect_to resource_index_path
  rescue
    render 'edit'
  end

  def destroy
    resource.destroy!
    redirect_to resource_index_path
  end

  private

  def downcase_class
    class_name.downcase
  end

  def class_name
    self.class.name.demodulize.sub(/Controller$/, '').singularize
  end

  def resource_class
    @resource_class ||=  begin
      namespaced_class = self.class.name.demodulize.sub(/Controller$/, '').singularize
      namespaced_class.constantize
    rescue NameError
      nil
    end
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
end
