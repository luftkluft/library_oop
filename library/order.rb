# frozen_string_literal: true

class Order
  attr_reader :book, :reader, :date

  def initialize(book, reader, date = Date.today)
    @book = book
    @reader = reader
    @date = date
  end

  def to_s
    "Book: '#{@book.title}' by #{@book.author}.\n
    Reader: #{@reader.name} (#{@reader.email})\n
    Order date: #{@date}."
  end
end
