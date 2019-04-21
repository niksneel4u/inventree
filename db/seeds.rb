# frozen_string_literal: true

User.find_or_initialize_by(
  phone_number: Rails.application.credentials.dig(:admin, :phone_number)
).tap do |admin_user|
  admin_user.first_name = 'admin'
  admin_user.last_name = 'admin'
  admin_user.password = Rails.application.credentials.dig(:admin, :password)
  admin_user.save!
  admin_user.add_role :admin
end

Entity.find_or_create_by!(name: 'name')
Entity.find_or_create_by!(name: 'price')
Entity.find_or_create_by!(name: 'image')