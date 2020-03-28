require_relative '../lib/game'
require_relative '../lib/frame'
require_relative './helpers/helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe Game do
    describe '#initialize' do
        it 'creates Game object with 10 Frames' do
          ten_frames = [*Array.new(9) { |i| Frame.new(2) }, Frame.new(3)]
          game = Game.new(ten_frames)
          expect(game.frames.length).to eq(10)
        end
    end

    describe '#save_score' do
        before(:each) do
          ten_frames = [*Array.new(9) { |i| Frame.new(2) }, Frame.new(3)]
          @game = Game.new(ten_frames)
        end
        it 'saves the 5 pinfalls of the first roll in the frame 1' do
            @game.save_score('5')
            expect(@game.frames[0].total_score).to eq(5)
        end

        it 'saves the strike in the frame 1' do
            @game.save_score('10')
            expect(@game.frames[0].boxes[0]).to eq(0)
            expect(@game.frames[0].boxes[1]).to eq(10)
        end

        it 'generates a game with 1 pinfall in 3 frames' do
            6.times do |i|
                    @game.save_score("#{i}")
            end
            expect(@game.frames[0].boxes[0]).to eq(0)
            expect(@game.frames[1].boxes[0]).to eq(2)
            expect(@game.frames[2].boxes[1]).to eq(5)
        end
    end

    describe 'Computing total score' do
        before(:each) do
            ten_frames = [*Array.new(9) { |i| Frame.new(2) }, Frame.new(3)]
            @game = Game.new(ten_frames)
        end

        it 'Total score 1 of a game with one pinfall in the first roll and the rest of roll with Fouls' do
            @game.save_score(1)
            19.times do |i|
                @game.save_score('F')
            end
            expect(@game.frames.last.total_score).to eq(1)
        end


        it 'Total score 0 when all the rolls are fouls' do
            20.times do |i|
                @game.save_score('F')
            end
            expect(@game.frames.last.total_score).to eq(0)
        end

        it "total score 24 with the secuence 6, 2, 7, 2, 3, 4" do
            simulating_game(@game, ['6', '2', '7', '2', '3', '4', *['F']*14])
            expect(@game.frames[0].total_score).to eq(8)
            expect(@game.frames[1].total_score).to eq(17)
            expect(@game.frames.last.total_score).to eq(24)
        end

        it "total score 20 and there is a spare" do
            simulating_game(@game, ['7', '3', '4', '2', *['F']*16])
            expect(@game.frames[0].total_score).to eq(14)
            expect(@game.frames[1].total_score).to eq(20)
            expect(@game.frames.last.total_score).to eq(20)
        end

        it "total score 28 and there is a strike" do
            simulating_game(@game, ['10', '3', '6', *['F']*17])
            expect(@game.frames[0].total_score).to eq(19)
            expect(@game.frames[1].total_score).to eq(28)
            expect(@game.frames.last.total_score).to eq(28)
        end 

        it "total score 120 and there is a strike" do
            simulating_game(@game, ['10', '10', '10', '10', *['F']*12])
            expect(@game.frames[0].total_score).to eq(30)
            expect(@game.frames[1].total_score).to eq(60)
            expect(@game.frames.last.total_score).to eq(90)
        end

        it "Total score 10 using the last frames"do
            simulating_game(@game, [*['F']*16,'3', '2', '4', '1'])
            expect(@game.frames.last.total_score).to eq(10)
        end

        it "Total score 18 using the last frames and a spare" do
            simulating_game(@game, [*['F']*16,'2', '8', '3', '2'])
            expect(@game.frames.last.total_score).to eq(18)
        end

        it "Total score 22 using the last frames and strikes" do
            simulating_game(@game, [*['F']*14,'10', '2', '2', '2', '2'])
            expect(@game.frames.last.total_score).to eq(22)
        end

        it "Total score 23 using the last frames and strikes" do
            simulating_game(@game, [*['F']*14,'2','3', '10', '2', '2' ])
            expect(@game.frames.last.total_score).to eq(23)
        end

        it "Perfect game" do
            simulating_game(@game, [*['10']*12])
            expect(@game.frames.last.total_score).to eq(300)
        end
        
        it "tests Example Jeff Player" do
            simulating_game(@game, ['10', '7', '3', '9', '0', '10',
                '0','8','8','2','0','6','10','10','10','8','1'])
            expect(@game.frames[2].total_score).to eq(48)
            expect(@game.frames[6].total_score).to eq(90)
            expect(@game.frames.last.total_score).to eq(167)
        end

        it "tests Example John Player" do
            simulating_game(@game, ['3', '7', '6', '3', '10',
                '8','1','10','10','9','0','7','3','4','4','10','9','0'])
            expect(@game.frames[2].total_score).to eq(44)
            expect(@game.frames[6].total_score).to eq(110)
            expect(@game.frames.last.total_score).to eq(151)
        end
        


    end
end