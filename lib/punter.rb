class Punter
  def punt(ball_on)
    max = 99 - ball_on
    rand(0..max)
  end
end