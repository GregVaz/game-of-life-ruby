### Conway's Game of Life
require_relative "cell"

class Board
  attr_reader :board, :status, :decease
  def initialize(rows = 8, cols = 8)
    @rows = rows
    @cols = cols
    @status = :alive
    @generations = Array.new
    @births = Array.new
    @deceases = Array.new
    @board = Array.new(rows) { |i|
      Array.new(cols) { |j|
        Cell.new([i,j], rand(0..1).to_i)
      }
    }
  end

  def iterationOf(gen)
    temp = @board.map(&:clone)
    iter_neighbors = 0
    cells_alive = 0
    deceases = 0
    rebirths = 0
    (0...@rows).each do |i|
      (0...@cols).each do |j|
        nb = evaluateOf(i,j)
        iter_neighbors += nb
        temp[i][j].evaluateOf(nb)
        cells_alive += 1 if temp[i][j].aliveOf
        deceases += 1 if temp[i][j].decease
        rebirths += 1 if temp[i][j].rebirth
      end
    end
    @generations.push(cells_alive)
    @deceases.push(deceases)
    @births.push(rebirths)
    if iter_neighbors == 0
      @status = :death
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
        print "#{@board[i][j].state == 1 ? "# " : "  "}"
      end
      puts ""
    end
    puts "- " * @cols
  end

  def boardStatus
    puts "3 ultimas generaciones de celulas: #{@generations.last(3)}"
    puts "3 ultimas generaciones de muertes: #{@deceases.last(3)}"
    puts "3 ultimas generaciones de nacimientos: #{@births.last(3)}"
    mortality = (@deceases.last.to_f / @generations.last.to_f) * 100
    natality = (@births.last.to_f / @generations.last.to_f) * 100
    puts "Tasa de mortalidad: #{mortality.round(2)}%"
    puts "Tasa de natalidad: #{natality.round(2)}%"
    if @generations.length > 2 && @generations.last(3).uniq.length == 1
      @status = :cycle
    end
    @status
  end
end

# board = Board.new
# while true
# board.printBoard
#   sleep 0.5
#   board.iterationOf
# end
