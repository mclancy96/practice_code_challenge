# Ruby ActiveRecord Practice Challenge

Welcome! This repository is designed to help you practice and master Ruby and ActiveRecord fundamentals. You will:

- Create your own database migrations
- Build models and set up associations
- Write and test class and instance methods
- Practice querying and manipulating data

---

## Getting Started

1. **Install dependencies:**

   ```sh
   bundle install
   ```
2. **Create your migrations:**

   - You are responsible for writing all migration files in `db/migrate/`.
   - At a minimum, create tables for:
     - `authors` (with at least a `name` column)
     - `books` (with at least a `title` column and a reference to `author`)
     - `genres` (with at least a `name` column)
     - `book_genres` (join table for books and genres)
   - Use appropriate data types and add timestamps.
   - Example command:
     ```sh
     bundle exec rake db:create_migration NAME=create_authors
     ```
3. **Run your migrations:**

   ```sh
   rake db:migrate
   ```
4. **Seed the database:**

   - Edit `db/seeds.rb` to add sample data for all tables and associations.
   - Run:
     ```sh
     rake db:seed
     ```
5. **Start an interactive console:**

   ```sh
   rake console
   ```

---

## Practice Domain

This project uses a simple library domain:

- **Author** has many Books
- **Book** belongs to Author; has many Genres through BookGenres
- **Genre** has many Books through BookGenres
- **BookGenre** is a join table for the many-to-many relationship

---

## Required Methods to Implement

For each model, implement the following methods. These are designed to cover a wide range of ActiveRecord and Ruby skills:

### Author

- `#books` — Returns all books written by this author (association method)
- `#genres` — Returns all unique genres for this author's books
- `.find_by_name(name)` — Class method to find an author by name
- `#book_count` — Returns the number of books written by this author
- `#most_recent_book` — Returns the most recently created book by this author
- `#books_in_genre(genre_name)` — Returns all books by this author in a given genre
- `.with_most_books` — Class method: returns the author(s) with the most books
- `.alphabetical` — Class method: returns all authors sorted by name
- `#co_authors` — Returns all other authors who have co-written a book with this author (if you add a co-author feature)
- `#first_book` — Returns the first book written by this author
- `#last_book` — Returns the last book written by this author
- `.with_no_books` — Class method: returns all authors with no books
- `.with_books_in_genre(genre_name)` — Class method: returns all authors who have written at least one book in the given genre
- `#has_written_in_genre?(genre_name)` — Returns true if the author has written a book in the given genre
- `#all_book_titles` — Returns an array of all this author's book titles

### Book

- `#author` — Returns the author of this book (association method)
- `#genres` — Returns all genres for this book (association method)
- `#description` — Returns a string in the format: "`<title>` by `<author name>`"
- `.by_genre(genre_name)` — Class method: returns all books in a given genre
- `.by_author(author_name)` — Class method: returns all books by a given author
- `.recent(limit = 5)` — Class method: returns the most recently created books (default 5)
- `.alphabetical` — Class method: returns all books sorted by title
- `#other_books_by_author` — Returns all other books by the same author
- `#shared_genres_with(other_book)` — Returns genres shared with another book
- `.without_genre(genre_name)` — Class method: returns all books not in the given genre
- `#all_genre_names` — Returns an array of this book's genre names
- `.by_title(title)` — Class method: returns all books with a given title
- `#in_genre?(genre_name)` — Returns true if this book is in the given genre

### Genre

- `#books` — Returns all books in this genre (association method)
- `#authors` — Returns all unique authors who have written books in this genre
- `.most_popular` — Class method: returns the genre with the most books
- `.alphabetical` — Class method: returns all genres sorted by name
- `#book_count` — Returns the number of books in this genre
- `#author_count` — Returns the number of unique authors in this genre
- `.with_no_books` — Class method: returns all genres with no books
- `#all_book_titles` — Returns an array of all book titles in this genre
- `.with_author(author_name)` — Class method: returns all genres that include books by the given author
- `.least_popular` — Class method: returns the genre with the fewest books
- `.with_books_by_multiple_authors` — Class method: returns all genres that have books by more than one author
- `#has_author?(author)` — Returns true if the given author has written a book in this genre
- `#oldest_book` — Returns the oldest book in this genre
- `#newest_book` — Returns the newest book in this genre
- `#books_by_author(author)` — Returns all books in this genre by a specific author

### BookGenre

- `#book` — Returns the associated book (association method)
- `#genre` — Returns the associated genre (association method)

---

#### Advanced/Bonus Methods (for extra challenge):

- Author: `.most_prolific`, `#all_genre_names`, `#all_genre_counts`, `.with_books_published_after(year)`, `.with_no_books`, `#first_book`, `#last_book`, `.with_books_in_genre(genre_name)`
- Book: `.published_before(year)`, `.published_after(year)`, `#genre_count`, `.with_multiple_genres`, `#co_authors`, `.without_genre(genre_name)`, `#all_genre_names`, `.by_title(title)`
- Genre: `.with_only_one_book`, `.with_no_authors`, `#all_author_names`, `.with_books_published_before(year)`,`.with_no_books`, `#all_book_titles`, `.with_author(author_name)`

---

## Running and Writing Tests

This repo uses RSpec for testing. Specs are provided for every required method in the `spec/models/` directory. You should:

- Implement the methods in your models so that all specs pass.
- Add more specs as you add new methods or want to test edge cases.

### To run all tests:

```sh
bundle exec rspec
```

### To run a specific test file:

```sh
bundle exec rspec spec/models/author_spec.rb
```

Test files are organized by model. Edit or expand them as you build out your code!---

---

## Study Guide Topics

### Active Record Migrations

- Create and modify tables using migrations
- Use different column types (string, integer, text, etc.)
- Add and remove columns
- Add indexes and constraints

### Active Record Associations

- One-to-many: Author → Books
- Many-to-many: Book ↔ Genre (via BookGenre)
- Use association methods to navigate related data

### Class and Instance Methods

- Implement and use class methods (e.g., `self.find_by_name`)
- Implement and use instance methods (e.g., `author.books`)
- Understand when to use each

### Active Record Querying

- Use `.where`, `.find_by`, `.joins`, `.includes`, `.order`, `.limit`, etc.
- Filter, sort, and retrieve data efficiently

### Final Tips

- Write clean, modular code
- Test your code frequently in the console
- Use `rake console` to experiment and debug
- Focus on getting things working before optimizing or refactoring
- Read error messages carefully—they are your best debugging tool!

---

## Additional Challenges

- Add validations to your models
- Add more associations (e.g., reviews, users)
- Write scopes for common queries
- Refactor your code for clarity and efficiency

---

Happy coding and good luck on your assessment!
