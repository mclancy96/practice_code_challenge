# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'
require 'bundler/setup'
Bundler.require(:default, :test)

# Optionally require your app files here
require_relative '../app/models/author'
require_relative '../app/models/book'
require_relative '../app/models/genre'
require_relative '../app/models/book_genre'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
