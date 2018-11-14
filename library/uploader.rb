# frozen_string_literal: true

module Uploader
  MAIN_PATH_ROUTE = 'library/'
  MAIN_PATH_NAME = 'db'
  MAIN_PATH_FORMAT = '.yml'
  MAIN_PATH = MAIN_PATH_ROUTE + MAIN_PATH_NAME + MAIN_PATH_FORMAT

  def save_to_db(book:, author:, reader:, order:)
    library_db = [book, author, reader, order]
    File.open(MAIN_PATH, 'w') { |f| f.write library_db.to_yml }
  end

  private

  def load_db
    list = [Book, Reader, Author, Order, Date]
    YAML.safe_load(File.read(MAIN_PATH), list, [], [], true).to_a
  end
end