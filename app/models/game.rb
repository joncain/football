require 'active_support/core_ext/integer/inflections'

class Game
  attr_reader :possessor, :ball_on

  def initialize(team1, team2)
    @quarter = 1
    @clock = 15 * 60

    @team1 = team1
    @team2 = team2
    @possessor = coin_toss
    @down = 1
    @distance = 10
    place_ball
  end

  def announce_welcome
    puts "Welcome to beautiful #{venue}."
    # sleep 0.5
    puts "Today's matchup is #{@team1} vs #{@team2}."
  end

  def announce_coin_toss
    puts "#{@possessor} has won the coin toss and has elected to defer.\n\n"
  end

  def kick(type)
    play = @possessor.get_play(:special, type)
    kick_yards = play.execute(@ball_on, nil, @possessor)

    puts "#{@possessor} #{type}s the ball"
    puts "It's a #{kick_yards} yard #{type}"

    @ball_on += kick_yards
    change_possession(false)
    kick_yards
  end

  def run_possession
    loop do
      if @ball_on < 0
        safety
        break
      end

      if @ball_on >= 100
        touchdown
        break
      end

      if @down == 4
        if in_field_goal_range?
          announce_down_and_distance
          attempt_field_goal
          break
        end
        if in_the_red_zone? && @distance == 1
          continue
        else
          announce_down_and_distance
          kick(:punt)
          break
        end
      end

      announce_down_and_distance
      run_play
    end
  end

  def summary
    columns = {
      Team: 12,
      Score: 5,
      "Plays": 10,
      "Run Plays": 9,
      "Pass Plays": 10,
      "Yards": 5,
      "Run Yds": 7,
      "Pass Yds": 8
    }
    header_format = columns.map {|k, v|
      k == :Team ? "%-#{v}s" : "%#{v}s"
    }.join("|")
    puts header_format % columns.keys

    row_format = columns.map {|k, v|
      k == :Team ? "%-#{v}s" : "%#{v}d"
    }.join("|")
    # puts header_format
    # puts row_format

    [@team1, @team2].each do |team|
      puts row_format % team.game_stats
    end
  end

  private
  def touchdown
    puts "TOUCHDOWN!! #{@possessor}"
    @possessor.score += 7
    place_ball
    kick(:kick)
  end

  def attempt_field_goal
    puts "Field goal attempt #{field_goal_attempt} yards"
    if rand(1..100) > 50
      puts "It's good!"
      @possessor.score += 3
      place_ball
      kick(:kick)
    else
      puts "It's no good!"
      change_possession(false)
    end
  end

  def safety
    puts "SAFETY!!"
    non_possessor.score += 2
    kick(:kick)
  end

  def run_play
    o_play = @possessor.get_play(:offense)
    d_play = non_possessor.get_play(:defense)

    o_play.execute(@ball_on, d_play)
    puts "The #{o_play.type} goes for #{o_play.result} yards"

    set_down(o_play.result)
  end 

  def set_down(yards_gained)
    if @goal_to_go
      @down += 1
    elsif yards_gained >= @distance
      @distance = 10
      @down = 1
    else
      @down += 1
      @distance -= yards_gained
    end

    @ball_on += yards_gained
    @goal_to_go = true if @down == 1 && @ball_on >= 90
  end

  def coin_toss
    [@team1, @team2].sample
  end

  def change_possession(reset = true)
    @possessor = non_possessor
    @down = 1
    @distance = 10
    @goal_to_go = false
    if reset
      # E.g., don't reset after a missed field goal
      place_ball
    else
      # E.g., after a punt
      flip_field
    end
  end

  def flip_field
    @ball_on = 100 - @ball_on
  end

  def place_ball
    @ball_on = 25
  end

  def non_possessor
    @possessor == @team1 ? @team2 : @team1
  end

  def venue
    @team1.home_team ? @team1.venue : @team2.venue
  end

  def field_position
    if @ball_on < 50
      "their #{@ball_on}"
    elsif @ball_on == 50
      "the 50"
    else
      "the #{non_possessor} #{100 - @ball_on}"
    end
  end

  def in_the_red_zone?
    @ball_on >= 80
  end

  def distance
    if @goal_to_go
      "Goal"
    else
      @distance
    end
  end

  def field_goal_attempt
    (100 + 10) - @ball_on
  end

  def in_field_goal_range?
    true if @possessor.field_goal_range >= field_goal_attempt
  end

  def announce_down_and_distance
    puts "-" * 50
    puts "It's #{@down.ordinalize} and #{@distance}. #{@possessor} ball on #{field_position} yard line."
  end
end