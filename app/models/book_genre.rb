class BookGenre < ActiveRecord::Base
  belongs_to :book
  belongs_to :genre

  def description
    "#{book.title} by #{book.author}"
  end
end
