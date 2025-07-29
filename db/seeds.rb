# Clear existing data
Author.destroy_all
Book.destroy_all
Genre.destroy_all
BookGenre.destroy_all

# Seed genres
genre_names = [
  'Fantasy', 'Adventure', 'Science Fiction', 'Mystery', 'Romance', 'Horror', 'Historical', 'Thriller', 'Nonfiction', 'Biography'
]
genres = genre_names.map { |name| Genre.create(name: name) }

# Seed authors
author_names = [
  'J.K. Rowling', 'J.R.R. Tolkien', 'Isaac Asimov', 'Agatha Christie', 'Jane Austen', 'Stephen King', 'George Orwell', 'Ernest Hemingway', 'Mark Twain', 'Virginia Woolf',
  'F. Scott Fitzgerald', 'Harper Lee', 'Charles Dickens', 'Leo Tolstoy', 'Emily Brontë', 'Arthur Conan Doyle', 'C.S. Lewis', 'Suzanne Collins', 'J.D. Salinger', 'Margaret Atwood'
]
authors = author_names.map { |name| Author.create(name: name) }

# Helper for random title generation
adjectives = %w[Lost Secret Dark Bright Silent Hidden Ancient Final Broken Golden Crimson Silver Wild Forgotten Burning
                Shattered Infinite Whispering]
nouns = %w[Empire Forest Dream Shadow Flame River Tower Game Code Path Legacy Storm Mirror Song Maze Circle Stone
           Voyage Machine]

def random_title(adjectives, nouns)
  "The #{adjectives.sample} #{nouns.sample}"
end

books = []
100.times do |i|
  author = authors.sample
  title = random_title(adjectives, nouns) + " #{i + 1}"
  published_year = rand(1950..2025)
  books << Book.create(title: title, author: author, published_year: published_year)
end

# Assign genres to books (each book gets 1-3 genres)
books.each do |book|
  genres.sample(rand(1..3)).each do |genre|
    BookGenre.create(book: book, genre: genre)
  end
end

# Optionally, print a summary
puts "Seeded #{Author.count} authors, #{Genre.count} genres, #{Book.count} books, and #{BookGenre.count} book-genre associations."
