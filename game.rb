# Controls of game
#
#
require_relative "board"

puts "Bienvenido al juego de la vida"

def launch_menu
  puts "Selecciona una de las siguientes opciones para iniciar el juego"
  puts "(1) Juego por defecto (tablero 8*8)"
  puts "(2) Juego personalizado"
  puts "(3) Salir del juego"
  print "Opcion: "
  option = gets.chomp.to_i
  [1,2,3].include?(option) ? menu_option(option) : launch_menu
end

def menu_option(option)
  if option == 1
    board = Board.new
    start(board)
  elsif option == 2
    print "Cantidad de filas: "
    rows = gets
    print "Cantidad de columnas: "
    cols = gets
    board = Board.new(rows.to_i, cols.to_i)
    start(board)
  elsif option == 3
    raise SystemExit
  end
end

def start(board)
  generation = 0
  while board.status == :alive
     puts "\nGeneracion: #{generation}"
     board.printBoard
     sleep 0.7
     board.iterationOf
     board.boardStatus 
     generation += 1
  end
  if board.status == :death
    puts "\nNo hay sobrevivientes\n"
  elsif board.status == :cycle
    puts "\nSe han vuelto inmortales\n"
  end
end

launch_menu()
