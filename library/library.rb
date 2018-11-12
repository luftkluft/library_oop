class Library
  attr_reader :authors, :readers, :books, :orders

  begin
    parsed = YAML.load(File.open(INDEX_PATH))
    @books = parsed[:books]
    @authors = parsed[:authors]
    @readers = parsed[:readers]
    @orders = parsed[:orders]
    puts 'Default library loaded successfully.'
  rescue StandardError => e
    puts "Could not parse YAML: #{e.message}"
  end

  private

  def validation_string(string)
    return nil unless string.is_a?(String)
    return nil if string.empty?
    string
  end
end
