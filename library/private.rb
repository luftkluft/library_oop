module Private
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
      if line_count.zero?
        temp << "- !ruby/object:Order\n"
      else
        temp << '  '
        temp << line
      end
      line_count += 1
    end
    temp
  rescue ArgumentError => e
    puts "Failed to adapt data: #{e.message}"
  end
end
