# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BookGenre do
  let!(:author) { Author.create(name: 'Test Author') }
  let!(:book) { Book.create(title: 'Test Book', author: author) }
  let!(:genre) { Genre.create(name: 'Test Genre') }
  let!(:book_genre) { BookGenre.create(book: book, genre: genre) }

  describe '#book' do
    it 'returns the associated book' do
      expect(book_genre.book).to eq(book)
    end
  end

  describe '#genre' do
    it 'returns the associated genre' do
      expect(book_genre.genre).to eq(genre)
    end
  end
end
