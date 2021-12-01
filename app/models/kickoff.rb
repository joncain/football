class Kickoff < Play
  def execute(ball_on, d_play, team)
    # TODO: implement defense
    team.kicker.kick(ball_on)
  end
end