# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/game'
require_relative '../lib/frame'
require_relative './helpers/helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Player do
  describe '#initialize' do
    it 'Create player object with name and game as parameters' do
      ten_frames = [*Array.new(9) { |i| Frame.new(2) }, Frame.new(3)]
      game = Game.new(ten_frames)
      player = Player.new('Jeff', game)
      expect(player.name).to eq('Jeff')
      expect(player.game.frames.length).to eq(10)
    end
  end

  describe 'Player recording the rolls' do
    before(:each) do
      ten_frames = [*Array.new(9) { |i| Frame.new(2) }, Frame.new(3)]
      game = Game.new(ten_frames)
      @player = Player.new('Jeff', game)
      simulating_game(@player.game, %w[10 7 3 9 0 10
                                       0 8 8 2 F 6 10 10 10 8 1])
    end

    it 'player Jeff saves the strike in the frame 1' do
      @player.game.save_score('10')
      expect(@player.game.frames[0].boxes[0]).to eq(0)
      expect(@player.game.frames[0].boxes[1]).to eq(10)
    end
  end
end
