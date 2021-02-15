# class Cell
# 
class Cell
  
  def initialize
    @state = rand(0..1).to_i == 1
    @decease = false
    @reborn = false
  end

  def evaluate_state(neighbors)
    if neighbors > 3 || neighbors < 2
      set_state(false)
    elsif neighbors == 3
      set_state(true)
    else 
      set_state(@state)
    end
  end

  def set_state(new_state)
    @decease = @state && !new_state
    @reborn = !@state && new_state
    @state = new_state
  end

  def alive?
    @state
  end

  def reborn?
    @reborn
  end

  def die?
    @decease
  end

  def to_s
    @state ? "■ " : ". "
  end
end
