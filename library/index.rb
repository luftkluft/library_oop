require_relative 'library'
require_relative 'seeds'

library = Library.new

unless File.exist?('library/db.yaml')
  print 'Data are sown...'
  sleep(1)
  print '.'
  sleep(1)
  print '.'
  sleep(1)
  puts '.'

  library.save(seeds)
end

library.load

sleep(1)

puts 'Welcome to Library'
puts 'Enter \'help\' to see all available options'

loop do
  input = gets.chomp

  case input
  when /\Ahelp\z/i
    puts 'Help:'
  when /\Aexit\z/i
    break
  else puts 'Invalid command (enter \'help\' to see all options)'
  end
end
