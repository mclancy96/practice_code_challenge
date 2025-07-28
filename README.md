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

You are encouraged to:

- Add more columns to your tables (e.g., publication year, bio, etc.)
- Add validations or constraints
- Experiment with different data types

---

## Example Tasks & Queries

- List all books by a given author:
  ```ruby
  Author.find_by(name: "J.K. Rowling").books
  ```
- Find all books in a specific genre:
  ```ruby
  Book.joins(:genres).where(genres: { name: "Fantasy" })
  ```
- Get all genres for a book:
  ```ruby
  Book.first.genres
  ```
- List all authors who have written in a genre:
  ```ruby
  Genre.find_by(name: "Adventure").authors
  ```
- Use custom methods in your models (see `lib/models/` for examples)

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
