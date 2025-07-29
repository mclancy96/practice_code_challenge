class Genre < ActiveRecord::Base
  has_many :book_genres
  has_many :books, through: :book_genres

  def authors
    books.map(&:author).uniq
  end

  def self.most_popular
    Genre.all.max_by(&:book_count)
  end

  def book_count
    books.count
  end

  def self.alphabetical
    Genre.all.order(name: :asc)
  end

  def author_count
    authors.count
  end

  def self.with_no_books
    Genre.all.reject { |genre| genre.book_count.positive? }
  end

  def all_book_titles
    books.map(&:title)
  end

  def self.with_author(author_name)
    Genre.all.filter { |genre| genre.books.map(&:author).map(&:name).include?(author_name) }
  end

  def self.least_popular
    Genre.all.min_by(&:book_count)
  end

  def self.with_books_by_multiple_authors
    Genre.all.reject { |genre| genre.author_count <= 1 }
  end

  def has_author?(author)
    authors.include?(author)
  end

  def oldest_book
    books.order(published_year: :asc).first
  end

  def newest_book
    books.order(published_year: :desc).first
  end

  def books_by_author(author)
    books.where('author_id = ?', author.id)
  end

  def self.with_only_one_book
    Genre.all.filter { |genre| genre.book_count == 1 }
  end

  def self.with_no_authors
    Genre.all.select { |genre| genre.author_count.zero? }
  end

  def all_author_names
    authors.map(&:name)
  end

  def self.with_books_published_before(year)
    Book.published_before(year).flat_map(&:genres).uniq
  end
end
