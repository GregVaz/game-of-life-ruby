### Conway's Game of Life
require_relative "cell"

class Board
  attr_reader :board
  def initialize(rows = 5, cols = 5)
    @rows = rows
    @cols = cols
    @board = Array.new(rows) { |i|
      Array.new(cols) { |j|
        Cell.new([i,j], rand(0..1).to_i)
      }
    }
  end

  def iterationOf
    temp = @board.map(&:clone)
    (0...@rows).each do |i|
      (0...@cols).each do |j| 
        @board[i][j].evaluateOf(evaluateOf(i, j))
      end
    end
    @board = temp
  end

  def evaluateOf(i, j)
    @neighbors = 0
    ir_lim = i + 1 == @rows ? 0 : 1
    jr_lim = j + 1 == @cols ? 0 : 1
    il_lim = i - 1 < 0 ? 0 : -1
    jl_lim = j - 1 < 0 ? 0 : -1
    (il_lim..ir_lim).each do |ix|
      (jl_lim..jr_lim).each do |jx|
        @neighbors += @board[i+ix][j+jx].state
      end
    end
    @neighbors -= @board[i][j].state
    return @neighbors
  end

  def printBoard
    puts "- " * @cols
    for i in (0...@rows)
      for j in (0...@cols)
        print "#{@board[i][j].state} "
      end
      puts ""
    end
  end
end

# board = Board.new
# while true
# board.printBoard
#   sleep 0.5
#   board.iterationOf
# end
