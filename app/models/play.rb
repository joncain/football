class Play
  attr_accessor :phase, :type,
                :strength, :result
  attr_reader :verb
  def initialize(phase, type, strength = nil)
    @phase = phase # offense or defense
    @type = type # run|pass
    @verb = type
    @strength = strength # determines outcome when compared to opposing play
  end

  def execute(ball_on, d_play)
    # ball_on tells us the max yards possible to gain
    max_yards = 100 - ball_on

    # did the D match the O play type? 
    match_multiplier = d_play.type == @type ? 0 : 2

    # what is the difference in strength between O and D plays?
    strength_differential = @strength - d_play.strength

    # our magic formula
    yards_gained = @strength * (match_multiplier + strength_differential)

    # limit to max_yards
    @result = yards_gained <= max_yards ? yards_gained : max_yards
  end

  def to_s
    "#{@phase} - #{@type} - #{@strength}"
  end
end