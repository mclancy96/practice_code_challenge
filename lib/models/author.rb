class Author < ActiveRecord::Base
  has_many :books

  # Instance method: returns all genres for this author's books
  def genres
    books.includes(:genres).map(&:genres).flatten.uniq
  end

  # Class method: find author by name
  def self.find_by_name(name)
    find_by(name: name)
  end
end
