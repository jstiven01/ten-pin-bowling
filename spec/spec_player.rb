# frozen_string_literal: true

require_relative '../lib/player'

RSpec.describe Player do
  describe '#initialize' do
    it 'Create player object with name as a parameter' do
      player = Player.new('Jeff')
      expect(player.name).to eq('Jeff')
    end
  end
end
