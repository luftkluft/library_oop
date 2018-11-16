# frozen_string_literal: true

class Order
  attr_reader :book, :reader, :date
  include Validator

  def initialize(book, reader, date = Date.today)
    validate(book, reader, date)
    @book = book
    @reader = reader
    @date = date
  end

  private

  def validate(book, reader, date)
    check_class(book, Book)
    check_class(reader, Reader)
    check_class(date, Date)
  end
end
