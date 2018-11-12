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
    puts 'The number of readers that take one of the SOME_QUANTITY (top set of books)'
    puts 'most popular books; the user is counted once, without repetitions:'
    top_set(3)
    puts ''
  end

  def user_statistic
    puts 'User statistics: step 1/3:'
    puts "Enter quantity a top of #{@orders.collect(&:reader).uniq.count} readers are any that takes the most number of books:"
    input = gets.chomp
    case input
    when /\D/i
      quantity = 1
      puts 'Invalid quantity. Quantity = 1 will be used.'
    when /\d/i
      quantity = input.to_i
      quantity = @orders.collect(&:reader).uniq.count if quantity > @orders.collect(&:reader).uniq.count
    else
      quantity = 1
      puts 'Invalid quantity. Quantity = 1 will be used.'
    end
    top_reader(quantity)
    puts ''

    puts 'User statistics: step 2/3:'
    puts "Enter quantity a top of #{@orders.collect(&:book).uniq.count} books that was taken by readers the most times:"
    input = gets.chomp
    case input
    when /\D/i
      quantity = 1
      puts 'Invalid quantity. Quantity = 1 will be used.'
    when /\d/i
      quantity = input.to_i
      quantity = @orders.collect(&:book).uniq.count if quantity > @orders.collect(&:book).uniq.count
    else
      quantity = 1
      puts 'Invalid quantity. Quantity = 1 will be used.'
    end
    top_book(quantity)
    puts ''

    puts 'User statistics: step 3/3:'
    puts "The number of readers that take a top of #{@orders.collect(&:book).uniq.count} books;"
    puts 'the user is counted once, without repetitions.'
    puts 'Enter books quantity:'
    input = gets.chomp
    case input
    when /\D/i
      quantity = 1
      puts 'Invalid quantity. Quantity = 1 will be used.'
    when /\d/i
      quantity = input.to_i
      quantity = @orders.collect(&:book).uniq.count if quantity > @orders.collect(&:book).uniq.count
    else
      quantity = 1
      puts 'Invalid quantity. Quantity = 1 will be used.'
    end
    top_set(quantity)
    puts ''
  end

  private

  def top_set(quantity)
    uniq_readers_count = @orders.group_by(&:book).sort_by { |_, order| -order.count }
    .first(quantity).collect { |_, order| order }
    .flatten.collect(&:reader).uniq.count
    puts "The topset of #{quantity} books read by #{uniq_readers_count} readers."
  end

  def top_book(quantity)
    book_titles = Hash.new(0)
    @orders.group_by(&:book).each do |book, reader|
      book_titles.store(book.title, reader.count)
    end
    book_titles.sort_by{|key,value| -value}.first(quantity).each do
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
end
