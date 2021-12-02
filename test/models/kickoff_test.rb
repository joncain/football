require "minitest/autorun"

describe Kickoff do
  before do
    @play = Kickoff.new(:special, :kickoff, 3)
  end

  describe "verb" do
    it "defines verb as kick" do
      assert_equal(:kick, @play.verb)
    end
  end
end