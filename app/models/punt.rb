class Punt < Play
  def execute(ball_on, d_play, punter)
    punter.punt(ball_on)
  end
end