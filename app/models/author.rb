class Author < ActiveRecord::Base
  has_many :books

  def genres
    books.flat_map(&:genres).uniq
  end

  def book_count
    books.count
  end

  def most_recent_book
    books.order(published_year: :desc).first
  end

  def books_in_genre(genre)
    books.filter { |book| book.genres.map(&:name).include?(genre) }
  end

  def self.with_most_books
    max_count = max_book_count
    Author.all.select { |author| author.book_count == max_count }
  end

  def self.max_book_count
    Author.all.map(&:book_count).max
  end

  def self.alphabetical
    Author.all.order(name: :asc)
  end
end
