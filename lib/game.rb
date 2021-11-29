require 'active_support/core_ext/integer/inflections'

class Game
  def initialize(team1, team2)
    @quarter = 1
    @clock = 15 * 60

    @team1 = team1
    @team2 = team2
    @possessor = coin_toss
  end

  def announce_welcome
    puts "Welcome to beautiful #{venue}."
    # sleep 0.5
    puts "Today's matchup is #{@team1} vs #{@team2}."
  end

  def announce_coin_toss
    puts "#{@possessor} has won the coin toss and has elected to defer.\n\n"
  end

  def kick_off
    puts "-" * 50
    puts "#{@possessor} kicks the ball"
    change_possession
    puts "#{@possessor} calls for a fair catch. The ball will be spotted at the #{@possessor} 25 yard line."
    @ball_on = 25
  end

  def run_possession
    while true do
      if @ball_on < 0
        saftey
        break
      end

      if @ball_on >= 100
        touchdown
        break
      end

      if @down == 4
        if in_field_goal_range?
          attempt_field_goal
          break
        end
        if in_the_red_zone? && @distance == 1
          continue
        else
          punt
          break
        end
      end

      run_play
    end
  end

  private
  def touchdown
    puts "TOUCHDOWN!! #{@possessor}"
    @possessor.score += 7
    kick_off
  end

  def attempt_field_goal
    puts "-" * 50
    puts "It's #{@down.ordinalize} and #{distance}. #{@possessor} has the ball on #{field_position} yard line."
    puts "Field goal attempt #{field_goal_attempt} yards"
    if rand(1..100) > 50
      puts "It's good!"
      @possessor.score += 3
      change_possession
    else
      puts "It's no good!"
      change_possession(false)
    end
  end

  def safety
    puts "SAFETY!!"
    not_possessor.score += 2
    kick_off
  end

  def punt
    puts "-" * 50
    puts "It's #{@down.ordinalize} and #{@distance}. #{@possessor} has the ball on #{field_position} yard line."
    puts "#{@possessor} punts the ball"
    change_possession
  end

  def run_play
    puts "-" * 50
    puts "It's #{@down.ordinalize} and #{distance}. #{@possessor} has the ball on #{field_position} yard line."
    o_play = @possessor.get_play(:offense)
    d_play = non_possessor.get_play(:defense)

    yards_gained = o_play.execute(d_play)
    puts "The #{o_play.type} goes for #{yards_gained} yards"

    set_down(yards_gained)
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
    reset_ball if reset # E.g., don't reset after a missed field goal
  end

  def reset_ball
    @ball_on = 25
  end

  def non_possessor
    @possessor == @team1 ? @team2 : @team1
  end

  def venue
    @team1.is_home_team ? @team1.venue : @team2.venue
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

end