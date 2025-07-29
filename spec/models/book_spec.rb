# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Book do
  let!(:author) { Author.create(name: 'Test Author') }
  let!(:other_author) { Author.create(name: 'Other Author') }
  let!(:genre1) { Genre.create(name: 'Fantasy') }
  let!(:genre2) { Genre.create(name: 'Mystery') }
  let!(:book1) { Book.create(title: 'Book One', author: author, published_year: 1999) }
  let!(:book2) { Book.create(title: 'Book Two', author: author, published_year: 2001) }
  let!(:book3) { Book.create(title: 'Book Three', author: other_author, published_year: 2005) }
  let!(:bg1) { BookGenre.create(book: book1, genre: genre1) }
  let!(:bg2) { BookGenre.create(book: book1, genre: genre2) }
  let!(:bg3) { BookGenre.create(book: book2, genre: genre1) }
  let!(:bg4) { BookGenre.create(book: book3, genre: genre2) }

  describe '#author' do
    it 'returns the author of this book' do
      expect(book1.author).to eq(author)
    end
  end

  describe '#genres' do
    it 'returns all genres for this book' do
      expect(book1.genres).to match_array([genre1, genre2])
    end
  end

  describe '#description' do
    it 'returns a string in the format: "<title> by <author name>"' do
      expect(book1.description).to eq('Book One by Test Author')
    end
  end

  describe '.by_genre' do
    it 'returns all books in a given genre' do
      expect(Book.by_genre('Fantasy')).to include(book1, book2)
      expect(Book.by_genre('Mystery')).to include(book1, book3)
    end
  end

  describe '.by_author' do
    it 'returns all books by a given author' do
      expect(Book.by_author('Test Author')).to match_array([book1, book2])
      expect(Book.by_author('Other Author')).to match_array([book3])
    end
  end

  describe '.recent' do
    it 'returns the most recently created books' do
      expect(Book.recent(2)).to eq([book3, book2])
    end
  end

  describe '.alphabetical' do
    it 'returns all books sorted by title' do
      expect(Book.alphabetical).to eq([book1, book2, book3].sort_by(&:title))
    end
  end

  describe '#other_books_by_author' do
    it 'returns all other books by the same author' do
      expect(book1.other_books_by_author).to match_array([book2])
      expect(book3.other_books_by_author).to eq([])
    end
  end

  describe '#shared_genres_with' do
    it 'returns genres shared with another book' do
      expect(book1.shared_genres_with(book2)).to match_array([genre1])
      expect(book1.shared_genres_with(book3)).to match_array([genre2])
    end
  end

  describe '.without_genre' do
    it 'returns all books not in the given genre' do
      expect(Book.without_genre('Fantasy')).to match_array([book3])
    end
  end

  describe '#all_genre_names' do
    it 'returns an array of this book\'s genre names' do
      expect(book1.all_genre_names).to match_array(%w[Fantasy Mystery])
    end
  end

  describe '.by_title' do
    it 'returns all books with a given title' do
      expect(Book.by_title('Book One')).to match_array([book1])
    end
  end

  describe '#in_genre?' do
    it 'returns true if this book is in the given genre' do
      expect(book1.in_genre?('Fantasy')).to be true
      expect(book2.in_genre?('Mystery')).to be false
    end
  end
end

# Advanced/Bonus Methods
describe '.published_before' do
  it 'returns all books published before a given year' do
    # This test assumes a published_at or year column exists
    expect(Book.published_before(2000)).to be_a(Array)
  end
end

describe '.published_after' do
  it 'returns all books published after a given year' do
    expect(Book.published_after(2000)).to be_a(Array)
  end
end

describe '#genre_count' do
  it 'returns the number of genres for this book' do
    expect(book1.genre_count).to eq(2)
  end
end

describe '.with_multiple_genres' do
  it 'returns all books with more than one genre' do
    expect(Book.with_multiple_genres).to include(book1)
    expect(Book.with_multiple_genres).not_to include(book2, book3)
  end
end

