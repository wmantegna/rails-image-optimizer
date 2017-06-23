require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImageOptimWithPaperclipOnHerokuExampleAppRails41
  class Application < Rails::Application
    
    if !Rails.env.development?   
      config.paperclip_defaults = {
        storage: :s3,
        s3_protocol: "https",
        s3_region: ENV["AWS_S3_REGION"],
        s3_credentials: {
          s3_host_name: ENV["AWS_S3_HOST_NAME"],
          bucket: ENV['AWS_BUCKET'], 
          access_key_id: ENV['AWS_ACCESS_KEY_ID'], 
          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
        }
      }
    end
  end
end
