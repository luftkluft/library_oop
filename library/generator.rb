class Generator
  include FFakerData
  def generate
    unless File.exist?(INDEX_PATH)
      begin
        File.open(INDEX_PATH, 'w') { |f| f.write(generate_data.to_yaml) }
        puts 'Default library created successfully.'
      rescue StandardError => e
        puts "Could not save YAML: #{e.message}"
      end
    end
  end
end