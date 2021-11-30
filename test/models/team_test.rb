require "minitest/autorun"

describe Team do
  before do
    @team = Team.new("YYZ")
  end

  describe "initialization" do
    it "sets @name" do
      assert_equal(@team.name, "YYZ")
    end
    it "defaults @is_home_team to false" do
      assert_equal(@team.is_home_team, false)
    end
    it "defaults @score to 0" do
      assert_equal(@team.score, 0)
    end
    it "defaults @field_goal_range to > 0" do
      assert @team.field_goal_range > 0
    end
  end

  describe "get_play" do
    describe "offense" do
      phase = :offense

      it "gets a play" do
        play = @team.get_play(phase)
        assert play.phase == phase
      end
      it "records a play" do
        play = @team.get_play(phase)
        assert play.phase == phase
        assert @team.plays_run[phase].include?(play)
      end
    end

    describe "defense" do
      phase = :defense

      it "gets a play" do
        play = @team.get_play(phase)
        assert play.phase == phase
      end
      it "records a play" do
        play = @team.get_play(phase)
        assert play.phase == phase
        assert @team.plays_run[phase].include?(play)
      end
    end
  end
end