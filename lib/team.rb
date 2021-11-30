require './lib/play.rb'
require './lib/punter.rb'

class Team
  attr_accessor :name, :venue,
                :is_home_team, :score,
                :field_goal_range, :plays_run

  def initialize(name, venue = nil, is_home_team = false)
    @name = name
    @venue = venue
    @is_home_team = is_home_team
    @score = 0
    @field_goal_range = 40
    @plays_run = {
      offense: [],
      :defense => [],
      :special => []
    }
  end

  def get_play(phase)
    play = playbook.select{|play| play.phase == phase}.sample
    @plays_run[phase] << play
    play
  end

  def punt(ball_on)
    # TODO: vary punter skills
    Punter.new.punt(ball_on)
  end

  def game_stats
    runs = @plays_run[:offense].select {|play| play.type == :run}
    passes = @plays_run[:offense].select {|play| play.type == :pass}
    {
      team: @name,
      total_plays: plays_run[:offense].count,
      run_att: runs.count,
      pass_att: passes.count,
      total_yds: plays_run[:offense].sum {|play| play.result},
      run_yds: runs.sum {|play| play.result},
      pass_yds: passes.sum {|play| play.result}
    }
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
        Play.new(:defense, :pass, 5)
      ]
  end
end