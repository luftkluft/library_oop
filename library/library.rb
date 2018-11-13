# frozen_string_literal: true

class Library
  attr_reader :authors, :readers, :books, :orders

  include Errors

  def initialize(*)
    parsed = YAML.load(File.open(MAIN_PATH))
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
    puts "    Enter quantity a top of #{@orders.collect(&:reader).uniq.count} readers
    are any that takes the most number of books:"
    input = gets.chomp
    user_input(:reader, input, 1) { |i| top_reader(i) }

    puts 'User statistics: step 2/3:'
    puts "    Enter quantity a top of #{@orders.collect(&:book).uniq.count} books
    that was taken by readers the most times:"
    input = gets.chomp
    user_input(:book, input, 1) { |i| top_book(i) }

    puts 'User statistics: step 3/3:'
    puts "The number of readers that take a top of #{@orders.collect(&:book).uniq.count} books;"
    puts 'the user is counted once, without repetitions.'
    puts 'Enter books quantity:'
    input = gets.chomp
    user_input(:book, input, 3) { |i| top_set(i) }
  end

  def help
    f = File.open(HELP_PATH, 'r')
    f.each do |line|
      puts line
    end
  rescue StandardError => e
    puts "Could not load HELP: #{e.message}"
  end

  private

  def user_input(object_counting, input, default_quantity = 1)
    # connect this code if you want to stop the program when you enter an empty string
    # check_class(input, String)
    # check_empty_string(input)
    case input
    when /\D/i
      quantity = default_quantity
      puts "Invalid quantity. Quantity = #{default_quantity} will be used."
    when /\d/i
      quantity = input.to_i
      quantity = @orders.map(&object_counting).uniq.count if quantity > @orders.map(&object_counting).uniq.count
    else
      quantity = default_quantity
      puts "Invalid quantity. Quantity = #{default_quantity} will be used."
    end
    yield(quantity)
    puts ''
  end

  def top_set(quantity)
    uniq_readers_count = @orders.group_by(&:book).sort_by { |_, order| -order.count }
                                .first(quantity).map { |_, order| order }
                                .flatten.map(&:reader).uniq.count
    puts "The topset of #{quantity} books read by #{uniq_readers_count} readers."
  end

  def top_book(quantity)
    book_titles = Hash.new(0)
    @orders.group_by(&:book).each do |book, reader|
      book_titles.store(book.title, reader.count)
    end
    book_titles.sort_by { |_, value| -value }.first(quantity).each do |title, count|
      puts "Book '#{title}' took #{count} times."
    end
  end

  def top_reader(quantity)
    readers_names = Hash.new(0)
    @orders.group_by(&:reader).each do |reader, book|
      readers_names.store(reader.name, book.count)
    end
    readers_names.sort_by { |_, value| -value }.first(quantity).each do |name, count|
      puts "Reader #{name} took #{count} books."
    end
  end

  def check_empty_string(str)
    raise StringError if str.empty?
  end

  def check_class(input, klass)
    raise ClassError unless input.is_a? klass
  end
end
