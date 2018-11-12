# frozen_string_literal: true

module FFakerData
  def generate_data
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
                   ))

      authors.push(Author.new(
                     FFaker::Book.author,
                     FFaker::Book.description
                   ))
      books.push(Book.new(
                   FFaker::Book.title,
                   FFaker::Book.author
                 ))
    end

    orders.push(
      Order.new(books[0], readers[4]),
      Order.new(books[5], readers[4]),
      Order.new(books[1], readers[4]),
      Order.new(books[2], readers[4]),
      Order.new(books[2], readers[4]),
      Order.new(books[2], readers[3]),
      Order.new(books[3], readers[3]),
      Order.new(books[3], readers[3]),
      Order.new(books[3], readers[3]),
      Order.new(books[3], readers[2]),
      Order.new(books[4], readers[2]),
      Order.new(books[4], readers[2]),
      Order.new(books[4], readers[1]),
      Order.new(books[4], readers[1]),
      Order.new(books[4], readers[0]),
      Order.new(books[4], readers[0]),
      Order.new(books[4], readers[0]),
      Order.new(books[4], readers[0])
    )

    {
      readers: readers,
      authors: authors,
      books: books,
      orders: orders
    }
  end
end
