    require 'rspec'

    class Bookstore
      attr_reader :books

      def initialize
        @books = []
      end

      def add_book(book)
        @books << book
      end

      def total_price
        @books.map(&:price).sum
      end

      def book_titles
        @books.map(&:title)
      end

      def find_books_by_author(author)
        @books.select { |book| book.author == author }
      end

      def cheapest_book
        @books.min_by(&:price)
      end
    end

    class Book
      attr_reader :title, :author, :price

      def initialize(title, author, price)
        @title = title
        @author = author
        @price = price
      end
    end

    RSpec.describe Bookstore do
      describe '#add_book' do
        it 'adds a book to the bookstore' do
          bookstore = Bookstore.new
          book = Book.new('Title', 'Author', 10.99)

          bookstore.add_book(book)

          expect(bookstore.books).to include(book)
        end
      end

      describe '#total_price' do
        it 'calculates the total price of all books' do
          bookstore = Bookstore.new
          book1 = Book.new('Title 1', 'Author', 10.99)
          book2 = Book.new('Title 2', 'Author', 15.99)
          bookstore.add_book(book1)
          bookstore.add_book(book2)

          total = bookstore.total_price

          expect(total).to eq(26.98)
        end

        it 'returns 0 for an empty bookstore' do
          bookstore = Bookstore.new

          total = bookstore.total_price

          expect(total).to eq(0)
        end
      end

      describe '#book_titles' do
        it 'returns an array of book titles' do
          bookstore = Bookstore.new
          book1 = Book.new('Title 1', 'Author', 10.99)
          book2 = Book.new('Title 2', 'Author', 15.99)
          bookstore.add_book(book1)
          bookstore.add_book(book2)

          titles = bookstore.book_titles

          expect(titles).to contain_exactly('Title 1', 'Title 2')
        end

        it 'returns an empty array for an empty bookstore' do
          bookstore = Bookstore.new

          titles = bookstore.book_titles

          expect(titles).to be_empty
        end
      end

      describe '#find_books_by_author' do
        it 'returns an array of books by a specific author' do
          bookstore = Bookstore.new
          book1 = Book.new('Title 1', 'Author 1', 10.99)
          book2 = Book.new('Title 2', 'Author 2', 15.99)
          book3 = Book.new('Title 3', 'Author 1', 12.99)
          bookstore.add_book(book1)
          bookstore.add_book(book2)
          bookstore.add_book(book3)

          author1_books = bookstore.find_books_by_author('Author 1')

          expect(author1_books).to contain_exactly(book1, book3)
        end

        it 'returns an empty array for an author with no books' do
          bookstore = Bookstore.new

          author_books = bookstore.find_books_by_author('Author XYZ')

          expect(author_books).to be_empty
        end
      end

      describe '#cheapest_book' do
        it 'returns the cheapest book' do
          bookstore = Bookstore.new
          book1 = Book.new('Title 1', 'Author', 10.99)
          book2 = Book.new('Title 2', 'Author', 15.99)
          bookstore.add_book(book1)
          bookstore.add_book(book2)

          cheapest = bookstore.cheapest_book

          expect(cheapest).to eq(book1)
        end

        it 'returns nil for an empty bookstore' do
          bookstore = Bookstore.new

          cheapest = bookstore.cheapest_book

          expect(cheapest).to be_nil
        end
      end
    end
