require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ABCLTDA
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    # allow cross origin requests
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post patch put delete]
      end
    end
    config.time_zone = 'America/Bogota'
    config.active_record.default_timezone = :utc
    # background jobs
    config.active_job.queue_adapter = :delayed
    # serve images from asset pipeline in mailers
    config.asset_host = ENV['BASE_URL']

    # customize generators
    config.generators do |g|
      # g.test_framework :rspec, fixture: false
      # g.fixture_replacement :factory_bot, dir: 'spec/factories'
      # g.view_specs = false
      # g.helper_specs = false
      # g.routing_specs = false
      # g.request_specs = false
      # g.controller_specs = false
      # g.javascripts = false
      # g.assets = true # stylesheets
      # g.helper = true
    end
    config.generators.system_tests = nil

    config.assets.content_type_mappings = {
      svg: 'image/svg+xml'
    }

    # i18n
    config.i18n.default_locale = :es
  end
end
