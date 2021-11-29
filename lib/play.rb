class Play
  attr_accessor :phase, :type, :strength

  def initialize(phase, type, strength)
    @phase = phase # offense or defense
    @type = type # run or pass
    @strength = strength # determines outcome when compared to opposing play
  end

  def execute(ball_on, d_play)
    puts self
    puts d_play

    chess_multiplier = d_play.type == @type ? 0 : 2
    strength_multiplier = @strength - d_play.strength
    yards_gained = @strength * (chess_multiplier + strength_multiplier)
    max_yards = 100 - ball_on
    yards_gained <= max_yards ? yards_gained : max_yards
  end

  def to_s
    "#{@phase} - #{@type} - #{@strength}"
  end
end