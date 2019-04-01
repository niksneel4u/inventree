# frozen_string_literal: true

# Inherited Resource Controller
class InheritedResourcesController < ApplicationController
  before_action :set_resource, only: %i[edit update show destroy]
  def index
    @collections = resource_class.page(params[:page]).per(PER_PAGE_RECORDS)
  end

  def show; end

  def new
    @resource = resource_class.new
  end

  def create
    @resource = resource_class.new(resource_params)
    if @resource.save
      redirect_to resource_index_path, notice: t('inherited_resource.create.success', resource: resource_class)
    else
      render :new, notice: t('inherited_resource.create.error', resource: resource_class)
    end
  end

  def edit; end

  def update
    if @resource.update(resource_params)
      redirect_to resource_index_path, notice: t('inherited_resource.create.success', resource: resource_class)
    else
      render :edit, notice: t('inherited_resource.create.error', resource: resource_class)
    end
  end

  def destroy
    @resource.destroy
    redirect_to resource_index_path, notice: t('inherited_resource.destroy.success', resource: resource_class)
  end

  private

  def resource_class
    @resource_class ||= begin
      namespaced_class = self.class.name.demodulize.sub(/Controller$/, '').singularize
      namespaced_class.constantize
                        rescue NameError
                          nil
    end
  end

  def set_resource
    @resource = resource_class.find_by(id: params[:id]).tap do |resource|
      authorize resource, policy_class: EmployeePolicy
    end
  end

  def resource_params
    send("#{singular_controller}_params")
  end

  def resources_path
    send("#{controller_name}_path")
  end

  def resource_index_path
    send("#{controller_name.pluralize}_path")
  end

  def edit_resource_path(resource)
    send("edit_#{singular_controller}_path", resource)
  end

  def resource_path(resource)
    send("#{singular_controller}_path", resource)
  end

  def singular_controller
    @singular_controller ||= controller_name.singularize
  end

  def pundit_user
    current_employee
  end

  helper_method :edit_resource_path, :resources_path,
                :resource_path, :resource_class, :singular_controller, :set_resource
end