require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Inventree
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # Mailer Settings
    config.action_mailer.delivery_method = :smtp
    # protocol: Settings.mailer.protocol
    config.action_mailer.default_url_options = { host: 'localhost' }

    ActionMailer::Base.smtp_settings = {
      address: 'smtp.gmail.com',
      port: 587,
      authentication: 'plain',
      user_name: Rails.application.credentials.dig(:mailer, :email),
      password: Rails.application.credentials.dig(:mailer, :password),
      domain: 'gmail.com',
      enable_starttls_auto: true
    }
  end
end
