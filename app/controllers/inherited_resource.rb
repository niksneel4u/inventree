# frozen_string_literal: true

class InheritedResource < ApplicationController
  before_action :authenticate_user!

  def index
    @collections ||= resource_class.all
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
