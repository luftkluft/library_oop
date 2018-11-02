require 'date'

def seeds
  readers = [
    Reader.new('r_name_1', 'r_1@mail.com', 'r_city_1', 'r_street_1', 'r_house_1'),
    Reader.new('r_name_2', 'r_2@mail.com', 'r_city_2', 'r_street_2', 'r_house_2'),
    Reader.new('r_name_3', 'r_3@mail.com', 'r_city_3', 'r_street_3', 'r_house_3'),
    Reader.new('r_name_4', 'r_4@mail.com', 'r_city_4', 'r_street_4', 'r_house_4'),
    Reader.new('r_name_5', 'r_5@mail.com', 'r_city_5', 'r_street_5', 'r_house_5')
  ]

  authors = [
    Author.new('author_name_1', 'biography_1'),
    Author.new('author_name_2', 'biography_2'),
    Author.new('author_name_3', 'biography_3'),
    Author.new('author_name_4', 'biography_4'),
    Author.new('author_name_5', 'biography_5')
  ]

  books = [
    Book.new('book_title_1', authors[0]),
    Book.new('book_title_2', authors[1]),
    Book.new('book_title_3', authors[2]),
    Book.new('book_title_4', authors[3]),
    Book.new('book_title_5', authors[4]),
    Book.new('book_title_6', authors[0]),
    Book.new('book_title_7', authors[1]),
    Book.new('book_title_8', authors[2])
  ]

  orders = [
    Order.new(books[0], readers[4], Date.today),
    Order.new(books[1], readers[4], Date.today),
    Order.new(books[1], readers[4], Date.today),
    Order.new(books[2], readers[4], Date.today),
    Order.new(books[2], readers[4], Date.today),
    Order.new(books[2], readers[3], Date.today),
    Order.new(books[3], readers[3], Date.today),
    Order.new(books[3], readers[3], Date.today),
    Order.new(books[3], readers[3], Date.today),
    Order.new(books[3], readers[2], Date.today),
    Order.new(books[4], readers[2], Date.today),
    Order.new(books[4], readers[2], Date.today),
    Order.new(books[4], readers[1], Date.today),
    Order.new(books[4], readers[1], Date.today),
    Order.new(books[4], readers[0], Date.today)
  ]

  {
    readers: readers,
    authors: authors,
    books: books,
    orders: orders
  }
end
