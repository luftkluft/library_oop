# frozen_string_literal: true

class Generator
  include FFakerData
  def generate
    return if File.exist?(MAIN_PATH)

    begin
      File.open(MAIN_PATH, 'w') { |f| f.write(generate_data.to_yaml) }
      puts 'Default library created successfully.'
    rescue StandardError => e
      puts "Could not save YAML: #{e.message}"
    end
  end
end
