# class Cell
#

class Cell
  attr_reader :state
  def initialize(position, state)
    @position = position
    @state = state
  end

  def evaluateOf(neighbors)
    nb = neighbors
    if nb > 3 || nb < 2
      purgeOf(0)
    elsif nb == 3
      purgeOf(1)
    end
  end

  def purgeOf(newState)
    @state = newState
  end

  def aliveOf
    @state == 1
  end

end
