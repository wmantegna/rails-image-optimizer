require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImageOptimWithPaperclipOnHerokuExampleAppRails41
  class Application < Rails::Application
    
    pathUrl = '/:class/:attachment/:id/:style/:filename'
    unless Rails.env.production?
      pathUrl = 'dev/:class/:attachment/:id/:style/:filename'
    end

    config.paperclip_defaults = {
      storage: :s3,
      s3_region: ENV["AWS_S3_REGION"],
      s3_credentials: {
        s3_host_name: ENV["AWS_S3_HOST_NAME"],
        bucket: ENV['AWS_BUCKET'],
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      }, 
      url: ':s3_domain_url',
      path: pathUrl,
      processors:  [:thumbnail, :paperclip_optimizer],
      paperclip_optimizer: {
        nice: 19,
        jpegoptim: { allow_lossy: true, strip: :all, max_quality: 75 },
        jpegtran: { progressive: true},
        optipng: { level: 2 },
        pngout: { strategy: 1}
      },
      # path: "#{'public/' if Rails.env.test?}asset/:id/:style/:basename.:extension",
      convert_options: { :all => '-auto-orient +profile "exif"' },
      s3_headers: { 'Cache-Control' => 'max-age=600'}
    }
  end
end
