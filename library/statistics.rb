# frozen_string_literal: true

module Statistics
  top_objects(orders, :book, 1)

  top_objects(orders, :reader, 1)

  def quantity_of_readers_of_popular_books(orders, quantity = 3)
    top_objects(orders, :book, quantity).map { |_, order| order }.flatten.map(&:reader).uniq.count
  end

  private

  def top_objects(orders, object, quantity = 1)
    orders.group_by(&object).sort_by { |_book, order| -order.count }.first(quantity).to_h.keys
  end
end
