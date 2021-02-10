### Conway's Game of Life
require_relative "cell"
require_relative "statistics"

class Board
  attr_reader :status
  def initialize(rows = 8, cols = 8)
    @rows = rows
    @cols = cols
    @status = :alive
    @board = create_board
    @stats = Statistics.new
  end

  def create_board
    Array.new(@rows) { Array.new(@cols) { Cell.new } }
  end

  def generation
    next_board = @board.map(&:clone)
    (0...@rows).each do |i|
      (0...@cols).each do |j|
        cell = next_board[i][j]
        cell.evaluate_state(neighbors_counter(i,j))
        @stats.count_generation_stats(cell.alive?, cell.reborn?, cell.die?)
      end
    end
    @stats.update_generation_results
    @board = next_board
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
      @cols.times { |j| print "#{@board[i][j]}" }
      puts ""
    end
    puts "- " * @cols
  end

  def board_status
    @stats.print_stats
    if @stats.generations.last == 0
      @status = :death
    elsif @stats.generations.length > 3 && @stats.generations.last(3).uniq.length == 1
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
