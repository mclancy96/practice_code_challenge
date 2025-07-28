class Genre < ActiveRecord::Base
  has_many :book_genres
  has_many :books, through: :book_genres

  # Instance method: list all authors in this genre
  def authors
    books.includes(:author).map(&:author).uniq
  end
end
