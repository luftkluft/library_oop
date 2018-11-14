# frozen_string_literal: true

library = Library.new

unless File.size?(MAIN_PATH)
  authors = []
  readers = []
  books = []
  orders = []

  10.times do
    readers.push(Reader.new(
                   name: FFaker::Name.name.to_s,
                   email: FFaker::Internet.email.to_s,
                   city: FFaker::Address.city.to_s,
                   street: FFaker::Address.street_name.to_s,
                   house: FFaker::Address.building_number.to_i
                 ))
  end

  10.times do
    authors.push(Author.new(
                   FFaker::Book.author.to_s,
                   FFaker::Book.description.to_s
                 ))
  end

  10.times do
    books.push(Book.new(
                 FFaker::Book.title.to_s,
                 Author.new(FFaker::Book.author.to_s)
               ))
  end

  10.times do
    orders.push(Order.new(Book.new(
                            FFaker::Book.title.to_s,
                            Author.new(FFaker::Book.author.to_s)
                          ),
                          Reader.new(
                            name: FFaker::Name.name.to_s,
                            email: FFaker::Internet.email.to_s,
                            city: FFaker::Address.city.to_s,
                            street: FFaker::Address.street_name.to_s,
                            house: FFaker::Address.building_number.to_i
                          )))
  end

  library.save_to_db(book: books, author: authors, reader: readers, order: orders)
  library.init
end
library.load_db
