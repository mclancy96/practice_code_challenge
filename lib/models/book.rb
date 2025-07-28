class Book < ActiveRecord::Base
  belongs_to :author
  has_many :book_genres
  has_many :genres, through: :book_genres

  # Instance method: returns a string with book and author
  def description
    "#{title} by #{author.name}"
  end

  # Class method: books by genre
  def self.by_genre(genre_name)
    joins(:genres).where(genres: { name: genre_name })
  end
end
