# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/frame'

RSpec.describe Game do
  describe '#initialize' do
    it 'creates Game object with 10 Frames' do
      ten_frames = Array.new(9) { |_i| Frame.new(2) }
      game = Game.new(ten_frames)
      expect(game.frames.length).to eq(10)
    end
  end

  describe '#save_score' do
    before(:each) do
      ten_frames = Array.new(9) { |_i| Frame.new(2) }
      @game = Game.new(ten_frames)
    end
    it 'saves the 5 pinfalls of the first roll in the frame 1' do
      @game.save_score('5')
      expect(@game.frames[0].total_score).to eq(5)
    end

    it 'generates a game with 1 pinfall in 3 frames' do
      6.times do |i|
        @game.save_score(i.to_s)
      end
      expect(@game.frames[0].boxes[0]).to eq(0)
      expect(@game.frames[1].boxes[0]).to eq(2)
      expect(@game.frames[2].boxes[1]).to eq(5)
    end
  end
end
