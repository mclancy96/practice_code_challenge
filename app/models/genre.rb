class Genre < ActiveRecord::Base
  has_many :book_genres
  has_many :books, through: :book_genres
  has_many :authors, -> { distinct }, through: :books

  def self.most_popular
   Genre
    .left_joins(:books)
    .group('genres.id')
    .select('genres.*, COUNT(books.id) AS books_count')
    .order('books_count DESC')
    .first
  end

  def self.alphabetical
    all.order(name: :asc)
  end

  def book_count
    books.count
  end

  def author_count
    authors.count
  end

  def self.with_no_books
    Genre
      .left_joins(:books)
      .where(books: { id: nil })
  end

  def all_book_titles
    books.pluck(:title)
  end

  def self.with_author(author_name)
    author = Author.find_by(name: author_name)
    Genre
      .joins(:books)
      .where(books: { author_id: author.id })
  end

  def self.least_popular
    Genre
    .left_joins(:books)
    .group('genres.id')
    .select('genres.*, COUNT(books.id) AS books_count')
    .order('books_count DESC')
    .last
  end

  def self.with_books_by_multiple_authors
    Genre
      .joins(:books)
      .group('genres.id')
      .having("COUNT(DISTINCT author_id) > ?", 1)
  end

  def has_author?(author_name)
    books.any? { |book| book.author == author_name }
  end

  def oldest_book
    books.find_by(published_year: books.minimum(:published_year))
  end

  def newest_book
    books.find_by(published_year: books.maximum(:published_year))
  end

  def books_by_author(author_instance)
    if author_instance.nil?
      books.none
    else
      books.where(author_id: author_instance.id)
    end
  end
end
