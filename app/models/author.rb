class Author < ActiveRecord::Base
  has_many :books
  has_many :genres, -> { distinct }, through: :books

  def self.find_by_name(name)
    Author.find_by(name: name)
  end

  def book_count
    books.count
  end

  def most_recent_book
    books.last
  end

  def books_in_genre(genre)
    books.joins(:genres).where(genres: { name: genre })
  end

  def self.with_most_books
    authors_with_counts = Author
    .left_joins(:books)
    .group('authors.id')
    .select('authors.*, COUNT(books.id) AS books_count')

    max_count = authors_with_counts.map(&:books_count).max

    authors_with_counts.select { |author| author.books_count == max_count }
  end

  def self.alphabetical
    Author.order(:name)
  end

  def first_book
    books.first
  end

  def last_book
    books.last
  end

  def self.with_no_books
    Author.left_joins(:books).where(books: { id: nil })
  end

  def self.with_books_in_genre(genre)
    Author.joins(books: :genres).where(genres: { name: genre }).distinct
  end

  def has_written_in_genre?(genre_name)
    genres.any? { |genre| genre.name == genre_name }
  end

  def all_book_titles
    books.pluck(:title)
  end
end
