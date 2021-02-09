# class Cell
#

class Cell
  attr_reader :decease, :rebirth
  def initialize
    @state = rand(0..1).to_i
    @decease = false
    @rebirth = false
  end

  def evaluate_state(neighbors)
    if neighbors > 3 || neighbors < 2
      set_state(0)
    elsif neighbors == 3
      set_state(1)
    end
  end

  def set_state(new_state)
    @decease = @state == 1 && new_state == 0
    @rebirth = @state == 0 && new_state == 1
    @state = new_state
  end

  def alive?
    @state == 1
  end

end
