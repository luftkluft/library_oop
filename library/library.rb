require 'yaml'
require_relative 'book'

class Library
  attr_accessor :books

  def initialize(books = [])
    @books = books
  end

  def load(file_path = './db.yaml')
    parsed = YAML.safe_load(File.open(file_path))
    @books = parsed[:books]
    puts 'Data loaded successfully.'
  rescue ArgumentError => e
    puts "Could not parse YAML: #{e.message}"
  end
end
