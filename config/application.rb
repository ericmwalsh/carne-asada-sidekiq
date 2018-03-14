require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CarneAsadaSidekiq
  class Application < Rails::Application
    ::Dotenv::Railtie.load if Rails.env.development? || Rails.env.test?

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.cache_store = :redis_store, ENV['CACHE_REDIS_URL']
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W(
      #{config.root}/app
      #{config.root}/lib
    )

    config.eager_load_paths += %W(
      #{config.root}/lib
    )
  end
end
