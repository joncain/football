require('./lib/game.rb')
require('./lib/team.rb')

team1 = Team.new("Boise St", "Boise, ID: Home of the blue turf", true)
team2 = Team.new("Oklahoma St")
game = Game.new(team1, team2)
puts "*" * 50
game.announce_welcome
game.announce_coin_toss
game.kick_off

10.times do |i|
  puts "\nPOSSESSION #{i}"
  game.run_possession
end

puts "*" * 50
puts "#{team1} #{team1.score} - #{team2} #{team2.score}"

puts "-" * 50
puts "Game Stats"

game.summary