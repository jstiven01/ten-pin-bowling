# frozen_string_literal: true
require_relative '../lib/frame'
require_relative '../lib/game'
require_relative '../lib/player'

# Creating game, frames and players
ten_frames_player1 = [*Array.new(9) { |i| Frame.new(2) }, Frame.new(3)]
game_player1 = Game.new(ten_frames_player1)
player1 = Player.new(game_player1)
ten_frames_player2 = [*Array.new(9) { |i| Frame.new(2) }, Frame.new(3)]
game_player2 = Game.new(ten_frames_player2)
player2 = Player.new(game_player2)


File.open('results.txt', 'r') do |f|
  f.each_line do |line|
    if player1.name.nil?
      player1.set_name(line.split[0])
      player1.game.save_score(line.split[1])
    elsif player2.name.nil? && player1.name != line.split[0]
      player2.set_name(line.split[0])
      player2.game.save_score(line.split[1])
    elsif player1.name == line.split[0]
      player1.game.save_score(line.split[1])
    else
      player2.game.save_score(line.split[1])
    end
  end
end

p '***RESULTS***'
player1.print_game
p '-------------'
player2.print_game
