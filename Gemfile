source 'https://rubygems.org'

# core
ruby '~> 2.4'
gem 'rails', '~> 4.2.9'
gem 'puma'                      # web server
gem "rack-timeout"              # time-out (puma doesn't do this on it's own)

# background processing
gem 'redis'                     # background processing
gem 'resque'                    # back-end worker process
gem 'resque-scheduler'          # cron scheduling
gem 'resque-web', require: 'resque_web' # resque web interface (for use with prod)

# rails basics
gem 'jquery-rails'
gem 'uglifier'

# image processing
gem 'aws-sdk', '~> 2'           # Amazon Web Servicers for s3 dev
gem 'paperclip', '~> 5'         # Image Upload Library
gem 'paperclip-optimizer'       # image compression
gem 'image_optim'               # image compression
gem 'image_optim_rails'         # image compression
gem 'image_optim_pack'          # image compression
gem 'filesize'                  # filesize information
gem "delayed_paperclip"         # compress images with background worker
# gem 'delayed_job_active_record' # delayed_job back-end

group :production do
  gem 'pg'                  # postgreSQL database
  gem 'rails_12factor'      # heroku gem
end

group :development do
  gem 'sqlite3'             # sqlite database
  gem 'spring'              # speeds up dev by running your app in the background
end

group :development, :test do
  gem 'figaro'              # env var's

  gem 'pry-rails'           # Causes rails console to open pry
  gem 'pry-byebug'          # Adds step, next, finish, and continue commands and breakpoints
  gem 'pry-stack_explorer'  # Navigate the call-stack
  gem 'annotate'            # Annotate all your models, tests, fixtures, and factories
  gem 'quiet_assets'        # Turns off the Rails asset pipeline log
  gem 'better_errors'       # Replaces the standard Rails error page with a much better and more useful error page
  gem 'binding_of_caller'   # Advanced features for better_errors advanced features (REPL, local/instance variable inspection, pretty stack frame names)
  gem 'meta_request'        # Supporting gem for Rails Panel (Google Chrome extension for Rails development).
end