# Controls of game
#
#
require_relative "board"

def menu 
  puts "Bienvenido al juego de la vida"
  puts "Selecciona una de las siguientes opciones para iniciar el juego"
  puts "(1) Juego por defecto (tablero 8*8)"
  puts "(2) Juego personalizado"
  puts "(3) Salir del juego"
  print "Opcion: "
  option = gets
end

def start(board)
  generation = 0
   while true
     puts "\nGeneracion: #{generation}"
     board.printBoard
     sleep 0.7
     board.iterationOf(generation)
     status = board.boardStatus
     if status == :death
       puts "\nNo hay sobrevivientes\n"
       break
     elsif status == :cycle
       puts "\nSe han vuelto inmortales\n"
       break
     end
     generation += 1
  end
end

option = menu.to_i
fail ArgumentError if ![1,2,3].include?(option)
if option == 1
  board = Board.new
  start(board)
end
if option == 2
  print "Cantidad de filas: "
  rows = gets
  print "Cantidad de columnas: "
  cols = gets
  board = Board.new(rows.to_i, cols.to_i)
  start(board)
end
if option == 3
  raise SystemExit
end
