require "minitest/autorun"

describe Play do
  before do
    @o_run_3 = Play.new(:offense, :run, 3)
    @d_pass_0 = Play.new(:defense, :pass, 0)
  end

  describe "initialization" do
    it "sets @phase" do
      assert_equal(:offense, @o_run_3.phase)
    end
    it "sets @type" do
      assert_equal(:run, @o_run_3.type)
    end
    it "sets @strength" do
      assert_equal(3, @o_run_3.strength)
    end
  end

  describe "execute" do
    it "gains yard vs a weak defense" do
      # 3 * (2+3)
      @o_run_3.execute(0, @d_pass_0)
      assert_equal(15, @o_run_3.result)
    end

    it "doesn't gain more than max yards possible" do
      @o_run_3.execute(95, @d_pass_0)
      assert_equal(5, @o_run_3.result)
    end
  end
end