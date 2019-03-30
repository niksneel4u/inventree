# frozen_string_literal: true

# Users controlle with devise
class Users::RegistrationsController < Devise::RegistrationsController
  layout 'authentication'
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  attr_reader :company_params, :user_params, :phone_number, :company

  # GET /resource/sign_up
  def new
    @company = Company.new
    super
  end

  # POST /resource
  def create
    params_init(params)
    company = Company.create!(
      name: company_params[:name],
      contact_person_name: company_params[:contact_person_name],
      contact_person_number: phone_number,
      email: company_params[:email],
      terms_and_conditions: true,
      users_attributes: [user]
    )
    sign_in(company.users.last)
  end

  def params_init(params)
    @company_params = params[:company]
    @phone_number = company_params[:contact_person_number].to_i
    @user_params = params[:user]
  end

  def user
    {
      first_name: user_params[:first_name],
      last_name: user_params[:last_name],
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation],
      phone_number: phone_number
    }
  end
  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
