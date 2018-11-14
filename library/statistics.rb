# frozen_string_literal: true

module Statistics
  def top_book(orders, default_quantity = 1)
    sorted = orders.group_by(&:book).sort_by { |_book, order| -order.count }
    sorted.first(default_quantity).to_h.keys
  end

  def top_reader(orders, default_quantity = 1)
    sorted = orders.group_by(&:reader).sort_by { |_book, order| -order.count }
    sorted.first(default_quantity).to_h.keys
  end

  def quantity_of_readers_of_popular_books(orders, default_quantity = 3)
    orders.group_by(&:book).sort_by { |_, order| -order.count }
          .first(default_quantity).map { |_, order| order }
          .flatten.map(&:reader).uniq.count
  end
end