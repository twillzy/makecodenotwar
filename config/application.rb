require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tinderwar
  class Application < Rails::Application

    config.paperclip_defaults = {
      :storage => :s3,
      :s3_credentials => { 
         :bucket => "project-two",
         :access_key_id => "AKIAI77762335SOVG5KQ",
         :secret_access_key => "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",
         :s3_host_name => "s3-ap-southeast-2.amazonaws.com"
      }
    }

    config.active_record.raise_in_transactional_callbacks = true
  end
end
