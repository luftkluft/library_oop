# frozen_string_literal: true

require_relative 'autoload'

generator = Generator.new
generator.generate
library = Library.new
library.default_statistic

puts 'Welcome to Library'
puts 'Enter \'help\' to see all available options'

loop do
  puts '= Enter command ='
  input = gets.chomp
  case input
  when /\Ahelp\z/i
    library.help
  when /\Aus\z/i
    library.user_statistic
  when /\Aexit\z/i
    break
  else puts 'Invalid command (enter \'help\' to see all options).'
  end
end

    library.add_order
  when /\Aexit\z/i
    break
  else puts 'Invalid command (enter \'help\' to see all options).'
  end
end
