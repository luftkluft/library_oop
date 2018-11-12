require_relative 'autoload'

generator = Generator.new
generator.generate
library = Library.new

puts 'Welcome to Library'
puts 'Enter \'help\' to see all available options'

loop do
  puts '= Enter command ='
  input = gets.chomp

  case input
  when /\Ahelp\z/i
    library.help
  when /\Aexit\z/i
    break
  else puts 'Invalid command (enter \'help\' to see all options).'
  end
end
