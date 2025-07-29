require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection({
                                          adapter: 'sqlite3',
                                          database: 'db/development.db'
                                        })

# Load models
require_relative '../app/models/author'
require_relative '../app/models/book'
require_relative '../app/models/genre'
require_relative '../app/models/book_genre'
