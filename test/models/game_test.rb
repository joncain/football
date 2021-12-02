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
    it "sets @down" do
      assert_equal(1, @game.down)
    end
    it "sets @distance" do
      assert_equal(10, @game.distance)
    end
    it "sets @ball_on" do
      assert_equal(25, @game.ball_on)
    end
  end

  describe "kick" do
    describe "kickoff" do
      it "results in a touchback" do
        assert_equal(25, @game.ball_on)
        result = @game.kick
        assert_equal(25, @game.ball_on)
        assert_equal(50, result)
      end
      it "changes possessor" do
        before = @game.possessor
        @game.kick
        refute_equal(before, @game.possessor)
      end
    end

    describe "punt" do
      it "places the ball in the correct spot" do
        assert_equal(25, @game.ball_on)
        @game.possessor.punter.stub :punt, 44 do
          @game.kick(:punt)
          # Ball should be placed @ 69
          # Then the field is flipped
          assert_equal(31, @game.ball_on)
        end
      end
    end
  end

  describe "run_possession" do
    it "punts from the 25 on 4th & 10" do
      get_play_spy = -> (phase, type = nil) {
        case phase
        when :offense, :defense
          Play.new(phase, type, 0)
        when :special
          m = MiniTest::Mock.new
          m.expect :execute, -10, [25, nil, @game.possessor]
          m.expect :verb, :kick
          m.expect :verb, :kick
        end
      }

      @game.possessor.stub :get_play, get_play_spy do
        @game.non_possessor.stub :get_play, get_play_spy do
          # Plays are mocked to match which will result in 0 yards gained
          # Punt is mocked to -10 yards
          @game.run_possession
          assert_equal(85, @game.ball_on)
          assert_equal(1, @game.down)
          assert_equal(10, @game.distance)
        end
      end
    end
  end
end