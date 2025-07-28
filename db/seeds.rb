# Clear existing data
Author.destroy_all
Book.destroy_all
Genre.destroy_all
BookGenre.destroy_all

# Authors
rowling = Author.create(name: "J.K. Rowling")
tolkien = Author.create(name: "J.R.R. Tolkien")

# Genres
fantasy = Genre.create(name: "Fantasy")
adventure = Genre.create(name: "Adventure")

# Books
hp1 = Book.create(title: "Harry Potter and the Sorcerer's Stone", author: rowling)
hp2 = Book.create(title: "Harry Potter and the Chamber of Secrets", author: rowling)
lotr = Book.create(title: "The Lord of the Rings", author: tolkien)

# BookGenres (many-to-many)
BookGenre.create(book: hp1, genre: fantasy)
BookGenre.create(book: hp1, genre: adventure)
BookGenre.create(book: hp2, genre: fantasy)
BookGenre.create(book: lotr, genre: fantasy)
BookGenre.create(book: lotr, genre: adventure)
