require "minitest/autorun"

describe Game do
  before do
    @team1 = Team.new("BSU")
    @team1.home_team = true
    @team2 = Team.new("OSU")
    @game = Game.new(@team1, @team2)
  end

  describe "initialize" do
    it "sets possessor" do
      refute_equal(nil, @game.possessor)
    end
  end

  describe "kick" do
    it "results in a touchback" do
      assert_equal(25, @game.ball_on)
      result = @game.kick(:kick)
      assert_equal(25, @game.ball_on)
      assert_equal(50, result)
    end

    it "changes possessor" do
      before = @game.possessor
      @game.kick(:kick)
      refute_equal(before, @game.possessor)
    end
  end

end