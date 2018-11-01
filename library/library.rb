require 'yaml'
require_relative 'book'

class Library
  attr_accessor :books

  def initialize(books = [])
    @books = books
  end

  def load(file_path = 'library/db.yaml')
    parsed = YAML.load(File.open(file_path))
    @books = parsed[:books]
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
end
