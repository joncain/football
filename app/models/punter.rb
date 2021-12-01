class Punter
  attr_accessor :max_range

  def initialize(max_range = 55)
    @max_range = max_range
  end

  def punt(ball_on)
    max = [100 - ball_on, @max_range].min
    rand(10..max)
  end
end