# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Genre do
  let!(:author) { Author.create(name: 'Test Author') }
  let!(:other_author) { Author.create(name: 'Other Author') }
  let!(:genre1) { Genre.create(name: 'Fantasy') }
  let!(:genre2) { Genre.create(name: 'Mystery') }
  let!(:genre3) { Genre.create(name: 'Unused Genre') }
  let!(:book1) { Book.create(title: 'Book One', author: author, published_year: 1995) }
  let!(:book2) { Book.create(title: 'Book Two', author: author, published_year: 2005) }
  let!(:book3) { Book.create(title: 'Book Three', author: other_author, published_year: 2010) }
  let!(:bg1) { BookGenre.create(book: book1, genre: genre1) }
  let!(:bg2) { BookGenre.create(book: book1, genre: genre2) }
  let!(:bg3) { BookGenre.create(book: book2, genre: genre1) }
  let!(:bg4) { BookGenre.create(book: book3, genre: genre2) }

  describe '#books' do
    it 'returns all books in this genre' do
      expect(genre1.books).to match_array([book1, book2])
      expect(genre2.books).to match_array([book1, book3])
    end
  end

  describe '#authors' do
    it 'returns all unique authors who have written books in this genre' do
      expect(genre1.authors).to match_array([author])
      expect(genre2.authors).to match_array([author, other_author])
    end
  end

  describe '.most_popular' do
    it 'returns the genre with the most books' do
      expect(Genre.most_popular).to eq(genre1)
    end
  end

  describe '.alphabetical' do
    it 'returns all genres sorted by name' do
      expect(Genre.alphabetical).to eq([genre1, genre2, genre3].sort_by(&:name))
    end
  end

  describe '#book_count' do
    it 'returns the number of books in this genre' do
      expect(genre1.book_count).to eq(2)
      expect(genre2.book_count).to eq(2)
      expect(genre3.book_count).to eq(0)
    end
  end

  describe '#author_count' do
    it 'returns the number of unique authors in this genre' do
      expect(genre1.author_count).to eq(1)
      expect(genre2.author_count).to eq(2)
    end
  end

  describe '.with_no_books' do
    it 'returns all genres with no books' do
      expect(Genre.with_no_books).to include(genre3)
      expect(Genre.with_no_books).not_to include(genre1, genre2)
    end
  end

  describe '#all_book_titles' do
    it 'returns an array of all book titles in this genre' do
      expect(genre1.all_book_titles).to match_array([book1.title, book2.title])
    end
  end

  describe '.with_author' do
    it 'returns all genres that include books by the given author' do
      expect(Genre.with_author('Test Author')).to include(genre1, genre2)
      expect(Genre.with_author('Other Author')).to include(genre2)
      expect(Genre.with_author('Other Author')).not_to include(genre1)
    end
  end

  describe '.least_popular' do
    it 'returns the genre with the fewest books' do
      expect(Genre.least_popular).to eq(genre3)
    end
  end

  describe '.with_books_by_multiple_authors' do
    it 'returns all genres that have books by more than one author' do
      expect(Genre.with_books_by_multiple_authors).to include(genre2)
      expect(Genre.with_books_by_multiple_authors).not_to include(genre1)
    end
  end

  describe '#has_author?' do
    it 'returns true if the given author has written a book in this genre' do
      expect(genre1.has_author?(author)).to be true
      expect(genre1.has_author?(other_author)).to be false
    end
  end

  describe '#oldest_book' do
    it 'returns the oldest book in this genre' do
      expect(genre1.oldest_book).to eq(book1)
    end
  end

  describe '#newest_book' do
    it 'returns the newest book in this genre' do
      expect(genre1.newest_book).to eq(book2)
    end
  end

  describe '#books_by_author' do
    it 'returns all books in this genre by a specific author' do
      expect(genre2.books_by_author(author)).to match_array([book1])
      expect(genre2.books_by_author(other_author)).to match_array([book3])
    end
  end

  # Advanced/Bonus Methods
  describe '.with_only_one_book' do
    it 'returns all genres with only one book' do
      expect(Genre.with_only_one_book).to be_a(Array)
    end
  end

  describe '.with_no_authors' do
    it 'returns all genres with no authors' do
      expect(Genre.with_no_authors).to include(genre3)
    end
  end

  describe '#all_author_names' do
    it 'returns an array of all author names in this genre' do
      expect(genre1.all_author_names).to include(author.name)
    end
  end

  describe '.with_books_published_before' do
    it 'returns all genres with books published before a given year' do
      # This test assumes a published_at or year column exists
      expect(Genre.with_books_published_before(2000)).to be_a(Array)
    end
  end
end
