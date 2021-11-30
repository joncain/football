desc 'Play a football game'
task :play => :environment do
  team1 = Team.new("Boise St")
  team1.is_home_team = true
  team1.venue =  "Boise, ID: Home of the blue turf"

  team2 = Team.new("Oklahoma St")
  game = Game.new(team1, team2)
  puts "*" * 50
  game.announce_welcome
  game.announce_coin_toss
  game.kick_off
  
  2.times do |i|
    puts "\nPOSSESSION #{i}"
    game.run_possession
  end
  
  puts "-" * 50
  game.summary
end

task :default => :play