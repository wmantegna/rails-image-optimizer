require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImageOptimWithPaperclipOnHerokuExampleAppRails41
  class Application < Rails::Application
    
    s3 = YAML.load_file( "#{Rails.root}/config/amazon_s3.yml")[Rails.env]

    if !Rails.env.development?      
      config.paperclip_defaults = {
        storage: :s3,
        s3_credentials: s3,
        s3_protocol: "https",
      }
    end
  end
end
