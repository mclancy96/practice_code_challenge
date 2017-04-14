require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection({
  adapter: 'sqlite3',
  database: 'db/twitter.db'
  })

require_relative '../lib/tweet.rb'
require_relative '../lib/user.rb'
require_relative '../lib/tweets_app.rb'
