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
  puts '= Enter command ='
  input = gets.chomp

  case input
  when /\Ahelp\z/i
    library.help
  when /\Aall\z/i
    library.all
  when /\Atop_reader\z/i
    library.top_reader
  when /\Atop_book\z/i
    library.top_book
  when /\Atop_set\z/i
    library.top_set
  when /\Aadd_order\z/i
    library.add_order
  when /\Asave\z/i
    library.save(library)
  when /\Aexit\z/i
    break
  else puts 'Invalid command (enter \'help\' to see all options).'
  end
end
