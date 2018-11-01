params = []

puts 'Welcome to Library'
puts 'Enter \'help\' to see all available options'

loop do
  input = gets.chomp
  command, *params = input.split /\s/

  case command
  when /\Ahelp\z/i
    puts 'Help:'
  when /\Aexit\z/i
    break
  else puts 'Invalid command (enter \'help\' to see all options)'
  end
end
