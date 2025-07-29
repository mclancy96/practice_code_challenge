class Book < ActiveRecord::Base
  belongs_to :author
  has_many :book_genres
  has_many :genres, through: :book_genres

  def description
    "#{title} by #{author.name}"
  end

  def self.by_genre(genre)
    Book.all.filter { |book| book.genres.map(&:name).include?(genre) }
  end

  def self.by_author(author)
    Book.all.filter { |book| book.author.name == author }
  end

  def self.recent(limit)
    Book.order(published_year: :desc).limit(limit)
  end

  def self.alphabetical
    Book.all.order(title: :asc)
  end

  def other_books_by_author
    author.books.reject { |book| book.id == id }
  end

  def shared_genres_with(other_book)
    genres & other_book.genres
  end

  def self.without_genre(genre)
    Book.all.reject do |book|
      book.genres.map(&:name).include?(genre)
    end
  end

  def all_genre_names
    genres.map(&:name)
  end

  def self.by_title(search_title)
    Book.where('title = ?', search_title)
  end

  def in_genre?(genre)
    all_genre_names.include?(genre)
  end

  def self.published_before(year)
    Book.where('published_year < ?', year).to_a
  end

  def self.published_after(year)
    Book.where('published_year > ?', year).to_a
  end

  def genre_count
    genres.uniq.count
  end

  def self.with_multiple_genres
    Book.all.reject { |book| book.genre_count <= 1 }
  end
end
