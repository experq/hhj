require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Halloped
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Helsinki'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('public/universities/**/locales/*.{yml}').to_s]
    config.i18n.default_locale = ENV['DEFAULT_LOCALE'].presence || :fi

    # Fallbacks are configured to work only for dynamic values stored in database
    # Fallbacks are not supported for static strings that come from locales/:locale.yml files
    # See also initializers/i18n.rb
    # Note: Defining "config.i18n.fallbacks = false" and defining fallback maps in i18n.rb
    # seems to be only way to make this work correctly.
    config.i18n.fallbacks = false

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    # config.active_record.whitelist_attributes = true

    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false, :fixture_replacement => :factory_girl, :view_specs => false
      g.fixture_replacement :factory_girl, :dir=>"spec/factories"
    end

    # This should be removed when code base is migrated to strong parameters
    config.action_controller.permit_all_parameters = true
  end

  def self.languages
    [:fi, :sv, :en]
  end
end
