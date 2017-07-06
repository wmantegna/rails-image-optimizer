web: bundle exec puma -C config/puma.rb
worker: QUEUE=* bundle exec rake environment resque:work
resque: env TERM_CHILD=1 bundle exec rake resque:work