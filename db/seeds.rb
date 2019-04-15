# frozen_string_literal: true

admin_user = User.create!(
  first_name: 'admin',
  last_name: 'admin',
  password: Rails.application.credentials.dig(:admin, :password),
  phone_number: Rails.application.credentials.dig(:admin, :phone_number)
)
admin_user.add_role :admin
