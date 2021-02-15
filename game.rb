# Controls of game
require_relative "board"

puts "Bienvenido al juego de la vida"

def launch_menu
  puts "Choose one of the next options to continue"
  puts "(1) Default game (board 8*8)"
  puts "(2) Choose rows and cols for the board"
  puts "(3) Exit the game"
  print "Option: "
  option = gets.chomp.to_i
  [1,2,3].include?(option) ? menu_option(option) : launch_menu
end

def menu_option(option)
  case option
  when 1
    start
  when 2
    print "Number of rows: "
    rows = gets.chomp.to_i
    print "Number of columns: "
    cols = gets.chomp.to_i
    start(rows, cols)
  when 3
    raise SystemExit
  end
end

def start(rows = 8, cols = 8)
  board = Board.new(rows, cols)
  generation = 0
  while board.status == :alive
     system 'clear'
     puts "\nGeneration: #{generation}"
     board.print_board
     board.generation
     board.board_status
     sleep 0.7
     generation += 1
  end
  if board.status == :death
    puts "\nThere is no survivals\n"
  elsif board.status == :cycle
    puts "\nThey have become inmortals\n"
  end
end

launch_menu
