require 'yaml'
require_relative 'book'
require_relative 'author'
require_relative 'order'
require_relative 'reader'

class Library
  attr_accessor :authors, :readers, :books, :orders

  def initialize(books = [], orders = [], readers = [], authors = [])
    @books = books
    @orders = orders
    @readers = readers
    @authors = authors
  end

  def load(file_path = 'library/db.yaml')
    parsed = YAML.load(File.open(file_path))
    @books = parsed[:books]
    @authors = parsed[:authors]
    @readers = parsed[:readers]
    @orders = parsed[:orders]
    puts 'Data loaded successfully.'
  rescue ArgumentError => e
    puts "Could not parse YAML: #{e.message}"
  end

  def save(data, file_path = 'library/db.yaml')
    File.open(file_path, 'w') { |f| f.write(data.to_yaml) }
    puts 'Data saved successfully.'
  rescue ArgumentError => e
    puts "Could not save YAML: #{e.message}"
  end

  def all
    puts 'Books:'
    p = @orders.collect { |o| o.book.title + ' : ' + o.book.author.name }.uniq
    puts p
    puts 'Authors:'
    p = @orders.collect { |o| o.book.author.name + ' : ' + o.book.author.biography }.uniq
    puts p
    puts 'Readers:'
    p = @orders.collect { |o| o.reader.name + ' : ' + o.reader.email }.uniq
    puts p
    puts 'Orders:'
    p = @orders.collect { |o| o.book.title + ' : ' + o.reader.name + ' : ' + o.date.to_s }
    puts p
  end

  def top_reader
    puts 'Default quantity of returned top readers is 1.'
    puts "Enter the quantity of returned top readers unto #{@orders.collect(&:reader).uniq.count}:"
    quantity = 1
    i = gets.chomp
    case i
    when /\D/i
      quantity = 1
      puts 'Invalid quantity. Default quantity = 1 will be used.'
    when /\d/i
      quantity = i.to_i
      quantity = @orders.collect(&:reader).uniq.count if quantity > @orders.collect(&:reader).uniq.count
    else
      puts 'Default quantity = 1 will be used.'
    end
    puts "Best #{quantity} readers:"
    readers_names = Hash.new(0)
    @orders.collect { |o| o.reader.name }.each { |n| readers_names[n] += 1 }
    readers_names.sort_by { |a| a[1] }.reverse_each do |n, q|
      quantity -= 1
      next if quantity.negative?

      puts "-reader #{n} took books #{q} times"
    end
  end

  def top_book
    puts 'Default quantity of returned top books is 1.'
    puts "Enter the quantity of returned top books unto #{@orders.collect(&:book).uniq.count}:"
    quantity = 1
    i = gets.chomp
    case i
    when /\D/i
      quantity = 1
      puts 'Invalid quantity. Default quantity = 1 will be used.'
    when /\d/i
      quantity = i.to_i
      quantity = @orders.collect(&:book).uniq.count if quantity > @orders.collect(&:book).uniq.count
    else
      puts 'Default quantity = 1 will be used.'
    end
    puts "Best #{quantity} books:"
    books_titles = Hash.new(0)
    @orders.collect { |o| o.book.title }.each { |n| books_titles[n] += 1 }
    books_titles.sort_by { |a| a[1] }.reverse_each do |n, q|
      quantity -= 1
      next if quantity.negative?

      puts "-book #{n} took #{q} times"
    end
  end

  def top_set
    puts 'Default quantity of returned top bookset is 3.'
    puts "Enter the quantity of returned top bookset unto #{@orders.collect(&:book).uniq.count}:"
    quantity = 3
    i = gets.chomp
    case i
    when /\D/i
      quantity = 3
      puts 'Invalid quantity. Default quantity = 3 will be used.'
    when /\d/i
      quantity = i.to_i
      quantity = @orders.collect(&:book).uniq.count if quantity > @orders.collect(&:book).uniq.count
    else
      puts 'Default quantity = 3 will be used.'
    end
    puts "The topset of #{quantity} books read by #{uniq_readers_count(quantity)} readers."
  end

  def add_order
    puts ''
    puts 'Start adding order:'
    puts 'step 1/4: view library'
    all

    puts ''
    puts 'step 2/4: enter title from booklist'
    puts 'Books:'
    @books.collect { |b| puts b.title.to_s }
    puts '= Enter title of book ='
    i = gets.chomp
    if check_book_title?(i)
      @order_book_title = i.to_s
    else
      puts i.to_s + ' not found'
      @order_book_title = nil
    end

    puts ''
    puts 'step 3/4: enter name of reader from readerlist'
    puts 'Readers:'
    @readers.collect { |r| puts r.name.to_s }
    puts '= Enter name of reader ='
    i = gets.chomp
    if check_reader_name?(i)
      @order_reader_name = i.to_s
    else
      puts i.to_s + ' not found'
      @order_reader_name = nil
    end

    puts ''
    puts 'step 4/4: create order'
    @order_date = Date.today
    puts 'Date of order: ' + Date.today.to_s
    puts 'Reader name: ' + @order_reader_name if @order_reader_name
    puts 'Book title: ' + @order_book_title if @order_book_title
    if @order_book_title && @order_reader_name && @order_date
      create_order(@order_book_title, @order_reader_name, @order_date)
    else
      puts 'Invalid  data: unable create order.'
    end
  end

  private

  def uniq_readers_count(quantity)
    @orders.group_by(&:book).sort_by { |_book, order| order.count }
           .reverse.first(quantity).collect { |_book, order| order }
           .flatten.collect(&:reader).uniq.count
  end

  def check_book_title?(title)
    @compare_title = false
    @books.collect { |b| @compare_title = true if b.title == title.to_s }
    @compare_title
  end

  def check_reader_name?(name)
    @compare_reader = false
    @readers.collect { |r| @compare_reader = true if r.name == name.to_s }
    @compare_reader
  end

  def create_order(title, reader, data)
    @index_array = 0
    @books.collect do |b|
      @title_index = @index_array if b.title == title.to_s
      @index_array += 1
    end

    @index_array = 0
    @readers.collect do |r|
      @reader_index = @index_array if r.name == reader.to_s
      @index_array += 1
    end

    new_order = Order.new(books[@title_index], readers[@reader_index], data)
    file_path = 'library/db.yaml'
    File.open(file_path, 'a') { |f| f.write(yaml_adapter_to_add(new_order)) }
    puts 'Order saved successfully.'
    load
  rescue ArgumentError => e
    puts "Could not save YAML: #{e.message}"
  end

  def yaml_adapter_to_add(data)
    data = data.to_yaml
    line_count = 0
    temp = ""
    data.lines.each do |line|
      if line_count == 0
        temp << "- !ruby/object:Order\n"
        line_count += 1
      else
        temp << "  "
        temp << line
        line_count += 1
      end
    end
    temp
  rescue ArgumentError => e
    puts "Failed to adapt data: #{e.message}"
  end
end
