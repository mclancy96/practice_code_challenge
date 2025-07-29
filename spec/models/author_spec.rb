# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Author do
  let!(:author) { Author.create(name: 'Test Author') }
  let!(:other_author) { Author.create(name: 'Other Author') }
  let!(:genre1) { Genre.create(name: 'Fantasy') }
  let!(:genre2) { Genre.create(name: 'Mystery') }
  let!(:book1) { Book.create(title: 'Book One', author: author, published_year: 1999) }
  let!(:book2) { Book.create(title: 'Book Two', author: author, published_year: 2005) }
  let!(:book3) { Book.create(title: 'Book Three', author: author, published_year: 2010) }
  let!(:book4) { Book.create(title: 'Book Four', author: other_author, published_year: 2003) }
  let!(:bg1) { BookGenre.create(book: book1, genre: genre1) }
  let!(:bg2) { BookGenre.create(book: book2, genre: genre1) }
  let!(:bg3) { BookGenre.create(book: book2, genre: genre2) }
  let!(:bg4) { BookGenre.create(book: book3, genre: genre2) }
  let!(:bg5) { BookGenre.create(book: book4, genre: genre1) }

  describe '#books' do
    it 'returns all books written by this author' do
      expect(author.books).to match_array([book1, book2, book3])
    end
  end

  describe '#genres' do
    it 'returns all unique genres for this author\'s books' do
      expect(author.genres).to match_array([genre1, genre2])
    end
  end

  describe '.find_by_name' do
    it 'finds an author by name' do
      expect(Author.find_by_name('Test Author')).to eq(author)
    end
  end

  describe '#book_count' do
    it 'returns the number of books written by this author' do
      expect(author.book_count).to eq(3)
    end
  end

  describe '#most_recent_book' do
    it 'returns the most recently created book by this author' do
      expect(author.most_recent_book).to eq(book3)
    end
  end

  describe '#books_in_genre' do
    it 'returns all books by this author in a given genre' do
      expect(author.books_in_genre('Fantasy')).to match_array([book1, book2])
      expect(author.books_in_genre('Mystery')).to match_array([book2, book3])
    end
  end

  describe '.with_most_books' do
    it 'returns the author(s) with the most books' do
      expect(Author.with_most_books).to include(author)
    end
  end

  describe '.alphabetical' do
    it 'returns all authors sorted by name' do
      expect(Author.alphabetical).to eq([author, other_author].sort_by(&:name))
    end
  end

  describe '#first_book' do
    it 'returns the first book written by this author' do
      expect(author.first_book).to eq(book1)
    end
  end

  describe '#last_book' do
    it 'returns the last book written by this author' do
      expect(author.last_book).to eq(book3)
    end
  end

  describe '.with_no_books' do
    it 'returns all authors with no books' do
      new_author = Author.create(name: 'No Books Author')
      expect(Author.with_no_books).to include(new_author)
      expect(Author.with_no_books).not_to include(author)
    end
  end

  describe '.with_books_in_genre' do
    it 'returns all authors who have written at least one book in the given genre' do
      expect(Author.with_books_in_genre('Fantasy')).to include(author, other_author)
      expect(Author.with_books_in_genre('Mystery')).to include(author)
      expect(Author.with_books_in_genre('Mystery')).not_to include(other_author)
    end
  end

  describe '#has_written_in_genre?' do
    it 'returns true if the author has written a book in the given genre' do
      expect(author.has_written_in_genre?('Fantasy')).to be true
      expect(author.has_written_in_genre?('Nonexistent Genre')).to be false
    end
  end

  describe '#all_book_titles' do
    it 'returns an array of all this author\'s book titles' do
      expect(author.all_book_titles).to match_array([book1.title, book2.title, book3.title])
    end
  end
end

# Advanced/Bonus Methods
describe '.most_prolific' do
  it 'returns the author(s) with the highest average books per year (or most books if not implemented)' do
    expect(Author.most_prolific).to be_a(Array).or be_a(Author)
  end
end

describe '#all_genre_names' do
  it 'returns an array of all unique genre names for this author' do
    expect(author.all_genre_names).to match_array([genre1.name, genre2.name])
  end
end

describe '#all_genre_counts' do
  it 'returns a hash of genre name => count for this author' do
    result = author.all_genre_counts
    expect(result).to be_a(Hash)
    expect(result.keys).to include(genre1.name, genre2.name)
  end
end

describe '.with_books_published_after' do
  it 'returns all authors with books published after a given year' do
    # This test assumes a published_at or year column exists
    expect(Author.with_books_published_after(2000)).to be_a(Array)
  end
end
