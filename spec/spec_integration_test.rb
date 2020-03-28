# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/game'
require_relative '../lib/frame'
require_relative './helpers/helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe 'Integration Test', type: :feature do
  describe 'Integration Test' do
    before(:each) do
      ten_frames_player1 = [*Array.new(9) { |i| Frame.new(2) }, Frame.new(3)]
      game_player1 = Game.new(ten_frames_player1)
      @player1 = Player.new(game_player1)
      ten_frames_player2 = [*Array.new(9) { |i| Frame.new(2) }, Frame.new(3)]
      game_player2 = Game.new(ten_frames_player2)
      @player2 = Player.new(game_player2)
    end

    it 'Sample input (Jeff and John Players)' do
      running_game_from_file('two_players', @player1, @player2)
      expect(@player1.game.frames[2].total_score).to eq(48)
      expect(@player1.game.frames[6].total_score).to eq(90)
      expect(@player1.game.frames.last.total_score).to eq(167)

      expect(@player2.game.frames[2].total_score).to eq(44)
      expect(@player2.game.frames[6].total_score).to eq(110)
      expect(@player2.game.frames.last.total_score).to eq(151)
    end

    it 'Perfect score' do
      running_game_from_file('perfect_score', @player1, @player2)
      expect(@player1.game.frames[2].total_score).to eq(90)
      expect(@player1.game.frames[6].total_score).to eq(210)
      expect(@player1.game.frames.last.total_score).to eq(300)
    end

    it 'Zero score' do
      running_game_from_file('zero_score', @player1, @player2)
      expect(@player1.game.frames[2].total_score).to eq(0)
      expect(@player1.game.frames[6].total_score).to eq(0)
      expect(@player1.game.frames.last.total_score).to eq(0)
    end
  end
end
