require 'yaml'
require_relative 'book'
require_relative 'author'
require_relative 'order'
require_relative 'reader'

class Library
  attr_accessor :books

  def initialize(books = [])
    @books = books
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
end
