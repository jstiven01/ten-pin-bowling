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

  def frame_pinfalls(pinfalls)
    integer_pinfalls = format_pinfalls(pinfalls)
    if integer_pinfalls == 10 && @current_frame < 9
      @current_box +=1 
    end
    @frames[@current_frame].save_pinfalls(@current_box, integer_pinfalls)
  end

  def is_a_spare?
    @frames[@current_frame-1].boxes.sum == 10 &&  @frames[@current_frame-1].boxes.none?(0)
  end

  def is_there_strike?(index_frame)
    @frames[index_frame].boxes[1] == 10 &&  @frames[index_frame].boxes.any?(0)
  end

  def compute_last_frame_strike(index_frame)
    if @current_box === 2
      @frames[index_frame-2].add_to_total_score(@frames[index_frame].boxes[0])
      @frames[index_frame-1].add_to_total_score(20)
      @frames[index_frame-1].add_to_total_score(@frames[index_frame].boxes[1])
      @frames[index_frame].add_to_total_score(@frames[index_frame - 1].total_score)
    end
  end

  def compute_strike(index_frame)
    if @current_box == 1 && index_frame < 9
      if is_there_strike?(index_frame - 2) 
        @frames[index_frame-2].add_to_total_score(@frames[index_frame].total_score)
        @frames[index_frame - 1].total_score = @frames[index_frame - 2].total_score + 10 + @frames[index_frame].total_score
        @frames[index_frame].add_to_total_score(@frames[index_frame - 1].total_score)
      else 
        @frames[index_frame-1].add_to_total_score(@frames[index_frame].total_score)
        @frames[index_frame].add_to_total_score(@frames[index_frame - 1].total_score) 
      end
    elsif index_frame == 9 
      if is_there_strike?(index_frame - 2) && @frames[index_frame].boxes[0] == 10
        compute_last_frame_strike(index_frame)
      else
        @frames[index_frame-1].add_to_total_score(@frames[index_frame].boxes[@current_box])
        @frames[index_frame].add_to_total_score(@frames[index_frame - 1].total_score)
      end
    end
      
  end

  def compute_score
    if @current_frame != 0 
      if is_there_strike?(@current_frame - 1)
        compute_strike(@current_frame)
      elsif is_a_spare? && @current_box == 0    
        @frames[@current_frame-1].add_to_total_score(@frames[@current_frame].boxes[0]) 
      else
        @frames[@current_frame].add_to_total_score(@frames[@current_frame - 1].total_score)
      end
    end
  end

  def save_score(pinfalls)
    frame_pinfalls(pinfalls)
    compute_score
    @current_box += 1
    if @current_frame < 9 && @current_box == 2
      @current_box = 0
      @current_frame += 1
    end
  end
end
