require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Baukis2
  class Application < Rails::Application
    config.load_defaults 6.0

    config.time_zone = "Toyko"
    config.i18n.load.path +=
      Dir[Rails.root.join("cofig", "locales", "**", "*.{rb.yml}").to_s]
    config.i18n.default_locale = :ja
  end
end
