require 'yaml'
require_relative 'book'

class Library
  attr_accessor :books

  def initialize(books = [])
    @books = books
  end
end
