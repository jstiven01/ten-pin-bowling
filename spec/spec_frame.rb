require_relative '../lib/frame'

RSpec.describe Frame do
  describe '#initialize' do
    it 'Create Frame object with number of boxes' do
      frame = Frame.new(3) #Size of the last frame
      expect(frame.boxes.length).to eq(3)
    end
  end

  describe '#save_pinfalls' do
    before(:each) do
        @frame = Frame.new(2)
    end
    it 'saves 3 pinfalls in the first roll and total score is 3' do
        @frame.save_pinfalls(0, 3)
        expect(@frame.boxes[0]).to eq(3)
        expect(@frame.total_score).to eq(3)
    end

    it 'saves a strike in the first roll and total score is 10' do
        @frame.save_pinfalls(1, 10)
        expect(@frame.boxes[1]).to eq(10)
        expect(@frame.total_score).to eq(10)
    end

    it 'saves 3 and 6 pinfalls and total score is 9' do
        @frame.save_pinfalls(0, 3)
        @frame.save_pinfalls(1, 6)
        expect(@frame.total_score).to eq(9)
    end

  end

  describe '#add_total_score' do

    it 'returns total score 13 when the current score is 10 and the bonus is 3' do
        frame = Frame.new(2)
        frame.save_pinfalls(1, 10)
        expect(frame.add_to_total_score(3)).to eq(13)
    end

  end

  describe 'printing frames' do
    before(:each) do
        @frame = Frame.new(2)
    end
    it 'prints 5 and 3 pinfalls ' do
        @frame.save_pinfalls(0, 5)
        @frame.save_pinfalls(1, 3)
        expect(@frame.print_frame).to eq('5  3')
    end

    it 'prints a strike' do
        @frame.save_pinfalls(1, 10)
        expect(@frame.print_frame).to eq('   X')
    end

    it 'prints a spare' do
        @frame.save_pinfalls(0, 7)
        @frame.save_pinfalls(1, 3)
        expect(@frame.print_frame).to eq('7  /')
    end

    it 'prints triple strike in the frame of size 3' do
        last_frame = Frame.new(3)
        last_frame.save_pinfalls(0, 10)
        last_frame.save_pinfalls(1, 10)
        last_frame.save_pinfalls(2, 10)
        expect(last_frame.print_frame).to eq('X  X  X')
    end
  end


end