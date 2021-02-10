### Conway's Game of Life
require_relative "cell"

class Board
  attr_reader :status
  def initialize(rows = 8, cols = 8)
    @rows = rows
    @cols = cols
    @status = :alive
    @generations = Array.new
    @births = Array.new
    @deceases = Array.new
    @board = create_board
  end

  def create_board
    Array.new(@rows) { Array.new(@cols) { Cell.new } }
  end

  def generation
    next_board = @board.map(&:clone)
    iteration_state = Hash.new(0)
    (0...@rows).each do |i|
      (0...@cols).each do |j|
        count_neighbors = neighbors_counter(i,j)
        next_board[i][j].evaluate_state(count_neighbors)
        iteration_state[:neighbors] += count_neighbors
        iteration_state[:cells_alive] += 1 if next_board[i][j].alive?
        iteration_state[:deceases] += 1 if next_board[i][j].die?
        iteration_state[:rebirths] += 1 if next_board[i][j].reborn?
      end
    end
    update_iteration_board(iteration_state)
    @board = next_board
  end

  def update_iteration_board(iteration_state)
    @generations.push(iteration_state[:cells_alive])
    @deceases.push(iteration_state[:deceases])
    @births.push(iteration_state[:rebirths])
    @status = :death if iteration_state[:neighbors] == 0 
  end

  def neighbors_counter(i, j)
    neighbors = 0
    limits = round_limits(i,j)
    (limits[:i_left_limit]..limits[:i_rigth_limit]).each do |ix|
      (limits[:j_left_limit]..limits[:j_rigth_limit]).each do |jx|
        neighbors += 1 if @board[i+ix][j+jx].alive?
      end
    end
    neighbors -= 1 if @board[i][j].alive?
    neighbors
  end

  def round_limits(i, j)
    {
      i_rigth_limit: i + 1 == @rows ? 0 : 1,
      j_rigth_limit: j + 1 == @cols ? 0 : 1,
      i_left_limit: i - 1 < 0 ? 0 : -1,
      j_left_limit: j - 1 < 0 ? 0 : -1
    }
  end

  def print_board
    puts "- " * @cols
    @rows.times do |i|
      @cols.times { |j| print "#{@board[i][j].alive? ? "■ " : ". "}" }
      puts ""
    end
    puts "- " * @cols
  end

  def board_status
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
