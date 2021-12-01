class Team
  attr_accessor :name, :venue,
                :is_home_team, :score,
                :field_goal_range, :plays_run,
                :punter

  def initialize(name)
    @name = name
    @is_home_team = false
    @score = 0
    @field_goal_range = 40
    @plays_run = {
      offense: [],
      :defense => [],
      :special => []
    }
    @punter = Punter.new
  end

  def get_play(phase, type = nil)
    play = playbook.select{|play|
      play.phase == phase && (type.nil? || play.type == type)
    }.sample
    @plays_run[phase] << play
    play
  end

  def game_stats
    runs = @plays_run[:offense].select {|play| play.type == :run}
    passes = @plays_run[:offense].select {|play| play.type == :pass}
    [
      @name,
      @score,
      plays_run[:offense].count, #Total plays
      runs.count, # Run plays
      passes.count, # Pass plays
      plays_run[:offense].sum {|play| play.result}, # Total yard
      runs.sum {|play| play.result}, # Run yards
      passes.sum {|play| play.result} # Pass yards
  ]
  end

  def to_s
    @name
  end

  private
  
  def playbook
      [
        Play.new(:offense, :run, 1),
        Play.new(:offense, :run, 2),
        Play.new(:offense, :run, 3),
        Play.new(:offense, :run, 4),
        Play.new(:offense, :run, 5),
        Play.new(:offense, :pass, 1),
        Play.new(:offense, :pass, 2),
        Play.new(:offense, :pass, 3),
        Play.new(:offense, :pass, 4),
        Play.new(:offense, :pass, 5),
        Play.new(:defense, :run, 1),
        Play.new(:defense, :run, 2),
        Play.new(:defense, :run, 3),
        Play.new(:defense, :run, 4),
        Play.new(:defense, :run, 5),
        Play.new(:defense, :pass, 1),
        Play.new(:defense, :pass, 2),
        Play.new(:defense, :pass, 3),
        Play.new(:defense, :pass, 4),
        Play.new(:defense, :pass, 5),
        Punt.new(:special, :punt),
        Play.new(:special, :kickoff)
      ]
  end
end