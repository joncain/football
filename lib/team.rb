require './lib/play.rb'

class Team
  attr_accessor :name, :venue,
                :is_home_team, :score,
                :field_goal_range

  def initialize(name, venue = nil, is_home_team = false, field_goal_range = 40)
    @name = name
    @venue = venue
    @is_home_team = is_home_team
    @score = 0
    @field_goal_range = 40
  end

  def get_play(phase)
    playbook.select{|play| play.phase == phase}.sample
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