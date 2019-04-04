# frozen_string_literal: true

class InheritedResource < ApplicationController
  def index
    @collections ||= policy_scope(resource_class).all
  end

  def new
    @resource = resource_class.new
    authorize @resource
  end

  def create
    @resource = resource_class.new(resource_params)
    authorize @resource
    @resource.save!
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
end
