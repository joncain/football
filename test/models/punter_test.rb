  require "minitest/autorun"

describe Punter do
  before do
    @punter = Punter.new(45)
  end

  describe "initialization" do
    it "sets @max_range" do
      assert_equal(45, @punter.max_range)
    end
  end

  describe "punt" do
    it "punts in expected range" do
      bad_punter = Punter.new(10)
      result = bad_punter.punt(0)
      assert_equal(10, result)
    end
  end
end