# frozen_string_literal: true

class Frame
  attr_accessor :boxes
  attr_accessor :total_score

  def initialize(number_boxes)
    @boxes = [0] * number_boxes
    @fouls = [nil] * number_boxes
  end

  def save_pinfalls(position, pinfalls)
    pinfalls_integer = 0
    if pinfalls == 'F'
      @fouls[position] = pinfalls
    else
      pinfalls_integer = pinfalls.to_i
    end
    @boxes[position] = pinfalls_integer
    compute_total_score
  end

  def add_to_total_score(accumulative_score)
    @total_score += accumulative_score
  end

  def print_frame
    final_string = ''

    if @boxes.sum == 10 && @boxes.length == 2 && @boxes.count(0).zero?
      "#{@boxes[0]}  /"
    else
      @boxes.length.times do |i|
        final_string += if @boxes[i] == 10
                          'X  '
                        elsif @fouls[i]
                          'F  '
                        else
                          "#{@boxes[1] != 10 ? @boxes[i].to_s : ' '}  "
                        end
      end
      final_string.rstrip
    end
  end

  private

  def compute_total_score
    @total_score = @boxes.sum
    @total_score
  end
end
