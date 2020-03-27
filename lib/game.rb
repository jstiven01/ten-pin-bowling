# frozen_string_literal: true

class Game
  attr_accessor :frames

  def initialize(frames)
    @frames = frames
    @current_frame = 0
    @current_box = 0
  end

  def format_pinfalls(pinfalls)
    pinfalls == 'F' ? 0 : pinfalls.to_i
  end

  def frame_pinfalls(pinfalls, frame, number_roll)
    @frames[frame].save_pinfalls(number_roll, pinfalls)
  end

  def compute_score
    @frames[@current_frame].add_to_total_score(@frames[@current_frame - 1].total_score) if @current_frame != 0
  end

  def save_score(pinfalls)
    frame_pinfalls(format_pinfalls(pinfalls), @current_frame, @current_box)
    compute_score
    @current_box += 1
    if @current_frame < 9 && @current_box == 2
      @current_box = 0
      @current_frame += 1
    end
  end
end
