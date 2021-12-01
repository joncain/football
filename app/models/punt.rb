class Punt < Play
  def execute(ball_on, d_play, punter)
    # TODO: implement defense
    punter.punt(ball_on)
  end
end