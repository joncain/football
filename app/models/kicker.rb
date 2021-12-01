class Kicker
  attr_accessor :max_range

  def initialize(max_range = 55)
    @max_range = max_range
  end

  def kick(ball_on)
    50
  end
end