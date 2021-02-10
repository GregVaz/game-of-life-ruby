# Stats class
#

class Statistics
  attr_reader :generations

  def initialize
    @generations = Array.new
    @births = Array.new
    @deceases = Array.new
    set_generation_state
  end

  def count_generation_stats(alive, reborn, die) 
    @generation_state[:cells_alive] += 1 if alive
    @generation_state[:deceases] += 1 if die
    @generation_state[:reborns] += 1 if reborn
  end

  def update_generation_results
    @generations.push(@generation_state[:cells_alive])
    @deceases.push(@generation_state[:deceases])
    @births.push(@generation_state[:reborns])
    set_generation_state
  end

  def last_alive_cells_generations(generations = 3)
    @generations.last(generations)
  end

  def last_death_cells_generations(generations = 3)
    @deceases.last(generations)
  end

  def last_reborn_cells_generations(generations = 3)
    @births.last(generations)
  end

  def natality
    (@deceases.last.to_f / @generations.last.to_f) * 100
  end

  def mortality
    (@births.last.to_f / @generations.last.to_f) * 100
  end

  def print_stats
    puts "3 last generations of living cells: #{last_alive_cells_generations}"
    puts "3 last generations of dead cells: #{last_death_cells_generations}"
    puts "3 last generations of born cells: #{last_reborn_cells_generations}"
    puts "Mortality rate: #{mortality.round(2)}%"
    puts "Natality rate: #{natality.round(2)}%"
  end

  private

  def set_generation_state
    @generation_state = Hash.new(0)
  end
end
