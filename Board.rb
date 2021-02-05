### Conway's Game of Life

class Board
  attr_reader :nb
  def initialize(rows = 10, cols = 20)
    @rows = rows
    @cols = cols
    @nb = 0
    @board = Array.new(rows) { Array.new(cols) { rand(0..1).to_i } }
=begin
    @board = [
      [0,0,0,0,0,0,0,0],
      [0,1,0,1,0,0,0,0],
      [0,0,1,1,0,0,0,0],
      [0,0,1,0,0,0,1,0],
      [0,0,0,0,0,0,0,0],
      [0,0,0,0,1,1,0,0],
      [0,0,0,0,1,1,0,0],
      [0,0,0,0,0,0,0,0]
    ]
=end
  end

  def iterationOf
    temp = @board.map(&:clone)
    total = 0
    (0...@rows).each do |i|
      (0...@cols).each do |j|
        nb = evaluateOf(i, j)
        total += nb
        if nb > 3 || nb < 2
          temp[i][j] = 0
        elsif nb == 3
          temp[i][j] = 1
        else 
          temp[i][j] = @board[i][j]
        end
      end
    end
    @board = temp
    return total
  end

  def evaluateOf(i, j)
    @neighbors = 0
    ir_lim = i + 1 == @rows ? 0 : 1
    jr_lim = j + 1 == @cols ? 0 : 1
    il_lim = i - 1 < 0 ? 0 : -1
    jl_lim = j - 1 < 0 ? 0 : -1
    (il_lim..ir_lim).each do |ix|
      (jl_lim..jr_lim).each do |jx|
        @neighbors += @board[i+ix][j+jx]
      end
    end
    @neighbors -= @board[i][j]
    return @neighbors
  end

  def printBoard
    puts "- " * @cols
    for i in (0...@rows)
      for j in (0...@cols)
        # print @board[i][j] == 0 ? " |" : "#|"
        print @board[i][j] == 0 ? "  " : "# "
      end
      puts ""
      # puts "- " * @cols
    end
  end
end

board = Board.new
while true
  totalOfNe = board.iterationOf
  puts "Neighbors = #{totalOfNe}"
  if totalOfNe == 0
    puts "No survivals" 
    break 
  end
  board.printBoard
  sleep 0.5
end
