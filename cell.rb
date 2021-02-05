# class Cell
#

class Cell
  attr_reader :state, :decease, :rebirth
  def initialize(position, state)
    @position = position
    @state = state
    @decease = false
    @rebirth = false
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
    @decease = @state == 1 && newState == 0
    @rebirth = @state == 0 && newState == 1
    @state = newState
  end

  def aliveOf
    @state == 1
  end

end
