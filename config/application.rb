require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImageOptimWithPaperclipOnHerokuExampleAppRails41
  class Application < Rails::Application
    
    s3 = {"bucket"=>ENV['AWS_BUCKET'], 
      "access_key_id"=>ENV['AWS_ACCESS_KEY_ID'], 
      "secret_access_key"=>ENV['AWS_SECRET_ACCESS_KEY']}

    # if !Rails.env.development?      
      byebug
      config.paperclip_defaults = {
        storage: :s3,
        s3_credentials: s3,
        s3_protocol: "https",
      }
    # end
  end
end
