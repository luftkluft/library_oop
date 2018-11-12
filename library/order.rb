# frozen_string_literal: true

class Order
  attr_reader :book, :reader, :date

  def initialize(book, reader, date = Date.today)
    @book = book
    @reader = reader
    @date = date
  end

  def to_s
    "Book: '#{@book.title}' by #{@book.author.name}.\nReader: #{@reader.name} (#{@reader.email})\nOrder date: #{@date}."
  end
end
