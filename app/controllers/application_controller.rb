# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, Pundit::NotDefinedError, with: :user_not_authorized
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.has_role?('admin')
      marketplaces_path
    else
      products_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: %i[first_name last_name phone_number email remember_me]
    )
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[phone_number])
  end

  def current_company
    current_user&.company
  end
  helper_method :current_company

  private

  def user_not_authorized(exception)
    flash[:error] = t('pundit')
    redirect_to(request.referrer || root_path)
  end
end
