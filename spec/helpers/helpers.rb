# frozen_string_literal: true

module Helpers
  def simulating_game(game, pinfalls)
    pinfalls.length.times do |i|
      game.save_score(pinfalls[i])
    end
  end

  def running_game_from_file(name_file, player1, player2)
    File.open("spec/files/#{name_file}.txt", 'r') do |f|
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
  end
end
