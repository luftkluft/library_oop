require 'yaml'
require_relative 'const'
require_relative 'book'
require_relative 'author'
require_relative 'order'
require_relative 'reader'
require_relative 'private'
require_relative 'public'

class Library
  attr_accessor :authors, :readers, :books, :orders

  def initialize(books = [], orders = [], readers = [], authors = [])
    @books = books
    @orders = orders
    @readers = readers
    @authors = authors
  end

  include Public

  include Private
end
