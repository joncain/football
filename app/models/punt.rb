class Punt < Play
  def execute(ball_on, d_play, team)
    # TODO: implement defense
    team.punter.punt(ball_on)
  end
end