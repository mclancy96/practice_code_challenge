class Book < ActiveRecord::Base
  belongs_to :author
  has_many :book_genres
  has_many :genres, through: :book_genres

  def description
    "#{title} by #{author.name}"
  end

  def self.by_genre(genre_name)
    joins(:genres).where(genres: { name: genre_name })
  end

  def self.by_author(author_name)
    joins(:author).where(author: { name: author_name })
  end

  def self.recent(number_of_books)
    order(published_year: :desc).limit(number_of_books)
  end

  def self.alphabetical
    order(title: :asc)
  end

  def other_books_by_author
    Book.where(author_id: self.author_id).where.not(id: self.id)
  end

  def shared_genres_with(other_book)
    genres & other_book.genres
  end

  def self.without_genre(given_genre)
    where.not(id: Book.joins(:genres).where(genres: { name: given_genre }))
  end

  def all_genre_names
    genres.pluck(:name)
  end

  def self.by_title(title_name)
    all.where(title: title_name)
  end

  def in_genre?(genre_name)
    genres.exists?({name: genre_name})
  end
end
