# frozen_string_literal: true

module Uploader
  def save_to_db(books:, authors:, readers:, orders:)
    library_db = [books, authors, readers, orders]
    File.open(MAIN_PATH, 'w') { |f| f.write library_db.to_yaml }
  end

  def load_db
    list = [Book, Reader, Author, Order, Date]
    YAML.safe_load(File.read(MAIN_PATH), list, [], [], true).to_a
  end
end
