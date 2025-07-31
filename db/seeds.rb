require 'faker'

puts "Seeding data..."

# Clear old data
BookGenre.destroy_all
Book.destroy_all
Genre.destroy_all
Author.destroy_all

# Create Authors
authors = 10.times.map do
  Author.create!(
    name: Faker::Book.unique.author
  )
end

# Create Genres
genres = 10.times.map do
  Genre.create!(
    name: Faker::Book.unique.genre
  )
end

# Create Books
books = 20.times.map do
  Book.create!(
    title: Faker::Book.unique.title,
    author: authors.sample,
    published_year: rand(1900..2024)
  )
end

# Create BookGenres
50.times do
  BookGenre.create!(
    book: books.sample,
    genre: genres.sample
  )
end

puts "Seeding complete!"
