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

  def first_book
    books.order(published_year: :asc).first
  end

  def last_book
    books.order(published_year: :asc).last
  end

  def self.with_no_books
    Author.all.select { |author| author.book_count.zero? }
  end

  def self.with_books_in_genre(genre)
    return unless Genre.find_by(name: genre)

    Genre.find_by(name: genre).books.map(&:author).uniq
  end

  def has_written_in_genre?(genre)
    authors_in_genre = self.class.with_books_in_genre(genre)
    authors_in_genre ? authors_in_genre.include?(self) : false
  end

  def all_book_titles
    books.map(&:title)
  end

  def all_genre_names
    books.map(&:genres).flatten.uniq.map(&:name)
  end

  def all_genre_counts
    all_genre_names.tally
  end

  def self.with_books_published_after(year)
    Book.all.where('published_year > ?', year).map(&:author).uniq
  end
end
