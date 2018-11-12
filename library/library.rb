# frozen_string_literal: true

class Library
  attr_reader :authors, :readers, :books, :orders

  def initialize(books = [], orders = [], readers = [], authors = [])
    parsed = YAML.load(File.open(INDEX_PATH))
    @books = parsed[:books]
    @authors = parsed[:authors]
    @readers = parsed[:readers]
    @orders = parsed[:orders]
    puts 'Default library loaded successfully.'
  rescue StandardError => e
    puts "Could not parse YAML: #{e.message}"
  end

  def default_statistic
    puts '=Default statistic='
    puts 'A top reader is the one that takes the most number of books:'
    top_reader(1)
    puts ''
    puts 'The most popular book is the book that was taken by readers the most times:'
    top_book(1)
    puts ''
  end

  private

  def top_book(quantity)
    book_titles = Hash.new(0)
    @orders.group_by(&:book).each do |book, reader|
      book_titles.store(book.title, reader.count)
    end
    book_titles.sort_by.sort_by{|key,value| -value}.first(quantity).each do
      |title, count| puts "Book '#{title}' took #{count} times."
    end
  end

  def top_reader(quantity)
    readers_names = Hash.new(0)
    @orders.group_by(&:reader).each do |reader, book|
      readers_names.store(reader.name, book.count)
    end
    readers_names.sort_by.sort_by{|key,value| -value}.first(quantity).each do
      |name, count| puts "Reader #{name} took #{count} books."
    end
  end

  def validation_string(string)
    return nil unless string.is_a?(String)
    return nil if string.empty?
    string
  end

  def validation_integer(integer)
    return nil unless integer.is_a?(Integer)
    integer
  end
end
