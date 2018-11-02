def seeds
  readers = []

  authors = []

  books = [
    Book.new('Book_1', 'Author_1')
  ]

  orders = []

  {
    readers: readers,
    authors: authors,
    books: books,
    orders: orders
  }
end
