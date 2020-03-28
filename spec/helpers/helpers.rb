# frozen_string_literal: true

module Helpers
  def simulating_game(game, pinfalls)
    pinfalls.length.times do |i|
      game.save_score(pinfalls[i])
    end
  end
end
