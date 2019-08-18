require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Docking
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # Set time zone to Japan time
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    # Error message to form
    config.action_view.field_error_proc = proc do |html_tag, instance|
      if instance.is_a?(ActionView::Helpers::Tags::Label)
        # skip when label
        html_tag.html_safe
      else
        "<div class=\"has-error\">#{html_tag}<span class=\"help-block\">#{instance.error_message.first}</span></div>".html_safe
      end
    end

    # Constraints helper
    config.action_controller.include_all_helpers = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
