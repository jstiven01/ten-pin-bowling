# frozen_string_literal: true

class Player
  attr_accessor :name
  attr_accessor :game

  def initialize(game, name = nil)
    @name = name
    @game = game
  end

  def set_name(name_player)
    @name = name_player
  end

  def print_game
    header = 'Frame      '
    pinfalls = 'Pinfalls   '
    score = 'Score      '
    @game.frames.length.times do |i|
      header += "#{i + 1}     "
      pinfalls += "#{@game.frames[i].print_frame}  "
      score += "#{@game.frames[i].total_score}#{' ' * (6 - @game.frames[i].total_score.digits.length)}"
    end
    p header.rstrip
    p @name
    p pinfalls.rstrip
    p score.rstrip
  end
end
