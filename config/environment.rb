ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV.fetch('RACK_ENV', nil))

require_all 'app/models'
