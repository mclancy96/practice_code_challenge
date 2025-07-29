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
end
