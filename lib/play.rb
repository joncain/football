class Play
  attr_accessor :phase, :type, :strength

  def initialize(phase, type, strength)
    @phase = phase # offense or defense
    @type = type # run or pass
    @strength = strength # determines outcome when compared to opposing play
  end

  def execute(d_play)
    puts self
    puts d_play

    chess_multiplier = d_play.type == @type ? 0 : 2
    strength_multiplier = @strength - d_play.strength
    @strength * (chess_multiplier + strength_multiplier)
  end

  def to_s
    "#{@phase} - #{@type} - #{@strength}"
  end
end