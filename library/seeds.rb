def seeds
  readers = [
    Reader.new('reader_name_1', 'reader_1@mail.com', 'reader_street_1', 'reader_house_1'),
    Reader.new('reader_name_2', 'reader_2@mail.com', 'reader_street_2', 'reader_house_2'),
    Reader.new('reader_name_3', 'reader_3@mail.com', 'reader_street_3', 'reader_house_3'),
    Reader.new('reader_name_4', 'reader_4@mail.com', 'reader_street_4', 'reader_house_4'),
    Reader.new('reader_name_5', 'reader_5@mail.com', 'reader_street_5', 'reader_house_5')
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
    Order.new(books[0], readers[4], Time.zone.now),
    Order.new(books[1], readers[4], Time.zone.now),
    Order.new(books[1], readers[4], Time.zone.now),
    Order.new(books[2], readers[4], Time.zone.now),
    Order.new(books[2], readers[4], Time.zone.now),
    Order.new(books[2], readers[3], Time.zone.now),
    Order.new(books[3], readers[3], Time.zone.now),
    Order.new(books[3], readers[3], Time.zone.now),
    Order.new(books[3], readers[3], Time.zone.now),
    Order.new(books[3], readers[2], Time.zone.now),
    Order.new(books[4], readers[2], Time.zone.now),
    Order.new(books[4], readers[2], Time.zone.now),
    Order.new(books[4], readers[1], Time.zone.now),
    Order.new(books[4], readers[1], Time.zone.now),
    Order.new(books[4], readers[0], Time.zone.now)
  ]

  {
    readers: readers,
    authors: authors,
    books: books,
    orders: orders
  }
end
