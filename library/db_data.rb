# frozen_string_literal: true

require_relative 'autoload'

library = Library.new

if File.size?(MAIN_PATH)
  library.load_db
else
  authors = []
  readers = []
  books = []
  orders = []

  10.times do
    readers.push(Reader.new(
    name: FFaker::Name.name,
    email: FFaker::Internet.email,
    city: FFaker::Address.city,
    street: FFaker::Address.street_name,
    house: FFaker::Address.building_number
    )
    )
  end

  10.times do
    authors.push(Author.new(
    FFaker::Book.author,
    FFaker::Book.description
    )
    )
  end

  10.times do
    books.push(Book.new(
    FFaker::Book.title,
    FFaker::Book.author
    )
    )
  end

  10.times do
    orders.push(Order.new(
      books[ FFaker::Random.rand(0..9)],
      readers[ FFaker::Random.rand(0..9)]
    )
    )
  end

  lib = {
    readers: readers,
    authors: authors,
    books: books,
    orders: orders
  }

  library.save_to_db(book: lib.books, author: lib.authors,
                     reader: lib.readers, order: lib.orders)

  library.load_db
end
